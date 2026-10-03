import 'package:translation_api/src/sih26042/models/translation_request.dart';
import 'package:translation_api/src/sih26042/models/translation_result.dart';

abstract class TranslationCache {
  Future<TranslationResult?> get(TranslationRequest request);

  Future<void> put(TranslationRequest request, TranslationResult result);
}
