import 'package:flutter_test/flutter_test.dart';
import 'package:translation_api/translation_api.dart';

class _ThrowingTranslator implements Translator {
  @override
  Future<TranslationResult> translate(TranslationRequest request) {
    throw Exception('primary unavailable');
  }
}

class _PrimaryTranslator implements Translator {
  @override
  Future<TranslationResult> translate(TranslationRequest request) async {
    return TranslationResult(
      sourceLanguage: request.sourceLanguage,
      targetLanguage: request.targetLanguage,
      sourceText: request.text,
      translatedText: 'PRIMARY:${request.text}',
      provider: 'primary',
    );
  }
}

void main() {
  test('uses fallback translator when primary fails and caches result', () async {
    final cache = InMemoryTranslationCache();
    final service = ResilientTranslationService(
      primaryTranslator: _ThrowingTranslator(),
      fallbackTranslator: const DeterministicFallbackTranslator(
        dictionary: <String, String>{'नमस्ते': 'Johar'},
      ),
      cache: cache,
    );

    final request = TranslationRequest(
      sourceLanguage: LanguageIdentifier.hindi,
      targetLanguage: LanguageIdentifier.ho,
      text: 'नमस्ते',
    );

    final firstResult = await service.translate(request);
    expect(firstResult.translatedText, 'Johar');
    expect(firstResult.fromFallback, isTrue);
    expect(firstResult.fromCache, isFalse);

    final secondResult = await service.translate(request);
    expect(secondResult.translatedText, 'Johar');
    expect(secondResult.fromCache, isTrue);
  });

  test('uses primary translator and then serves cache', () async {
    final service = ResilientTranslationService(
      primaryTranslator: _PrimaryTranslator(),
      fallbackTranslator: const DeterministicFallbackTranslator(),
      cache: InMemoryTranslationCache(),
    );

    final request = TranslationRequest(
      sourceLanguage: LanguageIdentifier.hindi,
      targetLanguage: LanguageIdentifier.santhali,
      text: 'स्वागत है',
    );

    final firstResult = await service.translate(request);
    expect(firstResult.provider, 'primary');
    expect(firstResult.fromFallback, isFalse);

    final secondResult = await service.translate(request);
    expect(secondResult.fromCache, isTrue);
    expect(secondResult.translatedText, 'PRIMARY:स्वागत है');
  });
}
