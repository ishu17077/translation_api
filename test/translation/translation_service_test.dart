import 'package:flutter_test/flutter_test.dart';
import 'package:translation_api/src/service/translation/translation_contract.dart';
import 'package:translation_api/src/service/translation/translation_impl.dart';

void main() {
  late final ITranslationService translationService;

  setUpAll(() {
    translationService = TranslationService();
  });

  test("Checks if translatiion from text to text is working", () async {
    final res = await translationService.translate(
      sourceLanguage: "en",
      targetLanguage: "bn",
      input: "How r u?",
    );
    print(res.output[0].target);
    expect(res.output, isNotEmpty);
  });
}
