import 'package:translation_api/src/sih26042/models/language_identifier.dart';

class TranslationResult {
  final LanguageIdentifier sourceLanguage;
  final LanguageIdentifier targetLanguage;
  final String sourceText;
  final String translatedText;
  final String provider;
  final bool fromCache;
  final bool fromFallback;

  const TranslationResult({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.sourceText,
    required this.translatedText,
    required this.provider,
    this.fromCache = false,
    this.fromFallback = false,
  });

  TranslationResult copyWith({
    String? translatedText,
    String? provider,
    bool? fromCache,
    bool? fromFallback,
  }) {
    return TranslationResult(
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      sourceText: sourceText,
      translatedText: translatedText ?? this.translatedText,
      provider: provider ?? this.provider,
      fromCache: fromCache ?? this.fromCache,
      fromFallback: fromFallback ?? this.fromFallback,
    );
  }
}
