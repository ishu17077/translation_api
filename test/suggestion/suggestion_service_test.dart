import 'package:flutter_test/flutter_test.dart';
import 'package:translation_api/src/service/suggestion/suggestion_impl.dart';

void main() {
  late final SuggestionService suggestionService;

  setUpAll(() {
    suggestionService = SuggestionService();
  });

  test('SuggestionService rejects multi-word input before network call', () async {
    await expectLater(
      () => suggestionService.getSuggestion(sourceLanguage: 'bn', text: 'Hi all'),
      throwsException,
    );
  });

  test('SuggestionService rejects empty word after sanitization', () async {
    await expectLater(
      () => suggestionService.getSuggestion(sourceLanguage: 'bn', text: '...'),
      throwsException,
    );
  });
}
