# translation_api

Reusable Flutter/Dart package for the SIH26042 prototype:
**“AI-Powered Vernacular Pedagogy and Real-Time Translation Tool for Mother Tongue-Based Primary Education”**
(Problem statement identifier: SIH26042; original prompt text used “Al-Powered”, corrected here to “AI-Powered”).

## Problem context

Jharkhand’s **PALASH Mother Tongue-Based Multilingual Education (MTB-MLE)** initiative has shown measurable foundational literacy gains among tribal children. Scaling remains constrained because many teachers in tribal-area primary schools are Hindi-medium trained and are not proficient in **Ho, Mundari, and Santhali**.

This creates a classroom language gap across thousands of tribal-area schools and limits the reach of mother-tongue instruction unless a practical technology bridge is available.

## Proposed SIH26042 solution scope

This package documents and structures a reusable module to support a host app that can:

- Translate Hindi FLN content into tribal languages with contextual text output.
- Integrate synthesized audio generation for translated content (via injectable adapters).
- Support real-time Hindi voice → tribal-language voice translation flow, with a target latency of **≤ 3 seconds** at full implementation level.
- Generate bilingual worksheets and visual flashcards aligned to **NIPUN Bharat** outcomes.
- Work offline on low-end Android tablets after initial sync (through cache/fallback abstractions in this package and host-level storage/sync).

> Current status: this package provides reusable interfaces, orchestration, cache/fallback scaffolding, and deterministic demo behavior. It **does not claim production neural MT/STT/TTS or guaranteed sub-3-second latency**.

## Expected prototype deliverables alignment

- ✅ At least one tribal language flow represented by reusable language identifiers and translation request/result models.
- ✅ Voice translation integration boundary contracts included (STT/TTS interfaces).
- ✅ Bilingual worksheet output abstraction included.
- ✅ Offline-first cache/fallback abstractions for low-memory devices.
- ⏳ Demo video URL: `TODO`
- ⏳ Public project demo link: `TODO`

## Category and technology bucket

- **Category:** Software
- **Technology Bucket:** Smart Education

## Repository composition

User-supplied language mix for this repository:

- HTML: **69.4%**
- Dart: **30.3%**
- Java: **0.3%**

## Package architecture and process

### Core package responsibilities

- Domain models for language and translation request/result.
- `Translator` interface for pluggable translation backends.
- `TranslationCache` abstraction and in-memory implementation.
- `ResilientTranslationService` orchestration (cache → primary → fallback).
- Deterministic fallback translator for demos/tests/offline behavior simulation.
- Voice integration boundaries (`SpeechToTextEngine`, `TextToSpeechEngine`).
- Worksheet generation interface and mock implementation.

### Request flow (text translation)

1. Host app builds `TranslationRequest`.
2. Host app calls `ResilientTranslationService.translate(...)`.
3. Service checks cache first.
4. On cache miss, service tries primary translator adapter.
5. If primary fails (network/model unavailable), service uses fallback translator.
6. Result is returned to host app and saved to cache.

### Offline/cache flow

1. Host app syncs curriculum content when internet is available.
2. Translation requests use `TranslationCache` first.
3. If network is unavailable, fallback translator path still returns deterministic result.
4. Host app may replace in-memory cache with persistent local store (Hive/SQLite/etc.) through the same interface.

### Voice flow boundary

1. Host app records Hindi speech.
2. STT adapter (`SpeechToTextEngine`) converts audio to text.
3. Text translation uses translator orchestration.
4. TTS adapter (`TextToSpeechEngine`) synthesizes tribal-language audio.
5. Host app plays output audio.

### Worksheet and flashcard flow

1. Host app passes Hindi prompts to `WorksheetGenerator`.
2. Generator returns bilingual worksheet items + flashcard metadata.
3. Host app renders printable/exportable worksheet UI.

### Integration boundaries for eventual on-device NLP/TTS/STT

Swap in production adapters that implement package interfaces:

- `Translator` → on-device/edge MT engine adapter.
- `SpeechToTextEngine` → on-device STT adapter.
- `TextToSpeechEngine` → on-device TTS adapter.
- `TranslationCache` → persistent/offline-optimized storage adapter.

## Installation

### Git dependency

```yaml
dependencies:
  translation_api:
    git:
      url: https://github.com/ishu17077/translation_api.git
      ref: main
```

### Local path dependency

```yaml
dependencies:
  translation_api:
    path: ../translation_api
```

Then run:

```bash
flutter pub get
```

## Minimal Dart usage example

```dart
import 'package:translation_api/translation_api.dart';

Future<void> runDemo() async {
  final service = ResilientTranslationService(
    primaryTranslator: const DeterministicFallbackTranslator(
      providerName: 'primary-demo',
      dictionary: {'नमस्ते': 'Johar'},
    ),
    fallbackTranslator: const DeterministicFallbackTranslator(),
    cache: InMemoryTranslationCache(),
  );

  final result = await service.translate(
    const TranslationRequest(
      sourceLanguage: LanguageIdentifier.hindi,
      targetLanguage: LanguageIdentifier.ho,
      text: 'नमस्ते',
    ),
  );

  print(result.translatedText); // Johar
}
```

## How to include in an existing Flutter app

### 1) Add dependency in host app `pubspec.yaml`

Use one of the installation methods above.

### 2) Import and initialize in your service layer

```dart
import 'package:translation_api/translation_api.dart';

class ClassroomTranslationService {
  ClassroomTranslationService()
      : _translator = ResilientTranslationService(
          primaryTranslator: const DeterministicFallbackTranslator(
            providerName: 'network-adapter-placeholder',
          ),
          fallbackTranslator: const DeterministicFallbackTranslator(),
          cache: InMemoryTranslationCache(),
        );

  final Translator _translator;

  Future<TranslationResult> translateHindiToHo(String text) {
    return _translator.translate(
      TranslationRequest(
        sourceLanguage: LanguageIdentifier.hindi,
        targetLanguage: LanguageIdentifier.ho,
        text: text,
      ),
    );
  }
}
```

### 3) Example screen integration

```dart
import 'package:flutter/material.dart';
import 'package:translation_api/translation_api.dart';

class TranslationDemoScreen extends StatefulWidget {
  const TranslationDemoScreen({super.key});

  @override
  State<TranslationDemoScreen> createState() => _TranslationDemoScreenState();
}

class _TranslationDemoScreenState extends State<TranslationDemoScreen> {
  final TextEditingController _controller = TextEditingController();
  late final Translator _translator;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _translator = ResilientTranslationService(
      primaryTranslator: const DeterministicFallbackTranslator(
        dictionary: {'नमस्ते': 'Johar'},
      ),
      fallbackTranslator: const DeterministicFallbackTranslator(),
      cache: InMemoryTranslationCache(),
    );
  }

  Future<void> _translate() async {
    final result = await _translator.translate(
      TranslationRequest(
        sourceLanguage: LanguageIdentifier.hindi,
        targetLanguage: LanguageIdentifier.ho,
        text: _controller.text,
      ),
    );
    setState(() => _output = result.translatedText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SIH26042 Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _controller),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _translate, child: const Text('Translate')),
            const SizedBox(height: 12),
            Text(_output),
          ],
        ),
      ),
    );
  }
}
```

## Android 9+, low-memory, and offline considerations

- Target deployment: Android 9+ low-end tablets (including ~2 GB RAM constraints).
- Prefer small in-memory working sets and persistent local cache for repeated classroom content.
- Keep heavy STT/TTS/MT models out of UI isolate; load lazily and release resources when idle.
- Perform content synchronization in controlled batches and verify offline readiness at app startup.

## Testing

This package includes deterministic unit tests for:

- Public response/model parsing and API initialization.
- Resilient translation behavior (primary success, fallback path, cache hit path).
- Deterministic fallback translator behavior.

Run locally:

```bash
flutter test
flutter analyze
```

## Limitations

- No production neural MT model bundled in this package.
- No bundled STT/TTS engine implementation.
- Real-time voice latency target (≤3s) depends on host app integrations and runtime optimizations.
- Worksheet/flashcard generation is represented via interfaces and mock scaffolding.

## Roadmap

- Add persistent cache adapter reference implementations.
- Add optional host-app helper utilities for streaming voice translation.
- Integrate benchmarking hooks for latency and memory profiling on low-end Android devices.
- Add production adapter examples for one tribal language pipeline.

## How to recreate from the original README/template

The original README in this repository was the default generated Flutter package template with TODO placeholders.

Steps used to transform it into this project documentation:

1. Replace template TODO sections with SIH26042 problem context and goals.
2. Document real scope vs future integration boundaries to avoid overclaiming capabilities.
3. Add package-oriented architecture and host-app integration guidance.
4. Add truthful code examples based on implemented API.
5. Add deployment constraints, testing instructions, limitations, and roadmap sections.

## Contributing

Contributions are welcome through issues and pull requests. Please keep changes package-focused, maintain null safety, and include tests for public API behavior.

## License

This project is licensed under the repository’s [LICENSE](LICENSE).
