import 'package:translation_api/src/sih26042/models/language_identifier.dart';

class TranslationRequest {
  final LanguageIdentifier sourceLanguage;
  final LanguageIdentifier targetLanguage;
  final String text;
  final String? contextTag;

  const TranslationRequest({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.text,
    this.contextTag,
  });

  String cacheKey() {
    return '${sourceLanguage.code}|${targetLanguage.code}|'
        '${contextTag ?? ''}|${text.trim().toLowerCase()}';
  }

  TranslationRequest normalize() {
    return TranslationRequest(
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      text: text.trim(),
      contextTag: contextTag?.trim(),
    );
  }
}
