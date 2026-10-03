import 'package:translation_api/src/sih26042/models/worksheet_models.dart';

abstract class WorksheetGenerator {
  Future<BilingualWorksheet> buildWorksheet({
    required List<String> hindiPrompts,
    required String targetLanguageCode,
  });
}
