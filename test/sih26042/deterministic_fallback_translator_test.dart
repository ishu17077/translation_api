import 'package:flutter_test/flutter_test.dart';
import 'package:translation_api/translation_api.dart';

void main() {
  test('returns dictionary mapping when available', () async {
    const translator = DeterministicFallbackTranslator(
      dictionary: <String, String>{'नमस्ते': 'Johar'},
    );

    final result = await translator.translate(
      const TranslationRequest(
        sourceLanguage: LanguageIdentifier.hindi,
        targetLanguage: LanguageIdentifier.ho,
        text: 'नमस्ते',
      ),
    );

    expect(result.translatedText, 'Johar');
    expect(result.fromFallback, isTrue);
  });

  test('returns deterministic demo prefix when mapping missing', () async {
    const translator = DeterministicFallbackTranslator(dictionary: <String, String>{});

    final result = await translator.translate(
      const TranslationRequest(
        sourceLanguage: LanguageIdentifier.hindi,
        targetLanguage: LanguageIdentifier.mundari,
        text: 'पानी',
      ),
    );

    expect(result.translatedText, '[demo] पानी');
  });
}
