import 'package:translation_api/src/sih26042/models/translation_request.dart';
import 'package:translation_api/src/sih26042/models/translation_result.dart';
import 'package:translation_api/src/sih26042/services/translation_cache.dart';

class InMemoryTranslationCache implements TranslationCache {
  final Map<String, TranslationResult> _store = <String, TranslationResult>{};

  @override
  Future<TranslationResult?> get(TranslationRequest request) async {
    return _store[request.cacheKey()];
  }

  @override
  Future<void> put(TranslationRequest request, TranslationResult result) async {
    _store[request.cacheKey()] = result.copyWith(
      fromCache: false,
      fromFallback: false,
    );
  }
}
