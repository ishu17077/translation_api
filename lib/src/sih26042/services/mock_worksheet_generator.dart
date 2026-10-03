import 'package:translation_api/src/sih26042/models/worksheet_models.dart';
import 'package:translation_api/src/sih26042/services/worksheet_generator.dart';

class MockWorksheetGenerator implements WorksheetGenerator {
  @override
  Future<BilingualWorksheet> buildWorksheet({
    required List<String> hindiPrompts,
    required String targetLanguageCode,
  }) async {
    final items = hindiPrompts
        .map(
          (prompt) => WorksheetItem(
            promptInHindi: prompt,
            promptInTargetLanguage: '[$targetLanguageCode] $prompt',
          ),
        )
        .toList(growable: false);

    final flashcards = hindiPrompts
        .map(
          (prompt) => VisualFlashcard(
            keywordInHindi: prompt,
            keywordInTargetLanguage: '[$targetLanguageCode] $prompt',
          ),
        )
        .toList(growable: false);

    return BilingualWorksheet(items: items, flashcards: flashcards);
  }
}
