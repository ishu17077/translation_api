import 'package:translation_api/src/sih26042/models/translation_request.dart';
import 'package:translation_api/src/sih26042/models/translation_result.dart';
import 'package:translation_api/src/sih26042/services/translation_cache.dart';
import 'package:translation_api/src/sih26042/services/translator.dart';

class ResilientTranslationService implements Translator {
  final Translator primaryTranslator;
  final Translator fallbackTranslator;
  final TranslationCache? cache;

  const ResilientTranslationService({
    required this.primaryTranslator,
    required this.fallbackTranslator,
    this.cache,
  });

  @override
  Future<TranslationResult> translate(TranslationRequest request) async {
    final normalizedRequest = request.normalize();

    final cached = await cache?.get(normalizedRequest);
    if (cached != null) {
      return cached.copyWith(fromCache: true);
    }

    try {
      final primaryResult = await primaryTranslator.translate(normalizedRequest);
      await cache?.put(normalizedRequest, primaryResult);
      return primaryResult;
    } catch (_) {
      final fallbackResult = await fallbackTranslator.translate(normalizedRequest);
      await cache?.put(normalizedRequest, fallbackResult);
      return fallbackResult.copyWith(fromFallback: true);
    }
  }
}
