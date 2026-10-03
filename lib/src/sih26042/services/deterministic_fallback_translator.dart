import 'package:translation_api/src/sih26042/models/translation_request.dart';
import 'package:translation_api/src/sih26042/models/translation_result.dart';
import 'package:translation_api/src/sih26042/services/translator.dart';

class DeterministicFallbackTranslator implements Translator {
  final Map<String, String> dictionary;
  final String providerName;

  const DeterministicFallbackTranslator({
    this.dictionary = const <String, String>{
      'नमस्ते': 'Johar',
      'स्वागत है': 'Johar, suswagat',
      'यह एक परीक्षण है': 'Ena ek test reya',
    },
    this.providerName = 'deterministic-fallback',
  });

  @override
  Future<TranslationResult> translate(TranslationRequest request) async {
    final normalized = request.normalize();
    final translated = dictionary[normalized.text] ?? '[demo] ${normalized.text}';

    return TranslationResult(
      sourceLanguage: normalized.sourceLanguage,
      targetLanguage: normalized.targetLanguage,
      sourceText: normalized.text,
      translatedText: translated,
      provider: providerName,
      fromFallback: true,
    );
  }
}
