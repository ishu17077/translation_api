import 'package:translation_api/src/sih26042/models/translation_request.dart';
import 'package:translation_api/src/sih26042/models/translation_result.dart';

abstract class Translator {
  Future<TranslationResult> translate(TranslationRequest request);
}
