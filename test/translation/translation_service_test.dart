import 'package:flutter_test/flutter_test.dart';
import 'package:translation_api/translation_api.dart';

void main() {
  test('TranslationResponse parses API payload correctly', () {
    final response = TranslationResponse.fromJson(
      <String, dynamic>{
        'taskType': 'translation',
        'output': <Map<String, String>>[
          <String, String>{'source': 'नमस्ते', 'target': 'Johar'},
        ],
      },
    );

    expect(response.taskType, 'translation');
    expect(response.output, hasLength(1));
    expect(response.output.first.source, 'नमस्ते');
    expect(response.output.first.target, 'Johar');
  });

  test('TranslationApi initializes all services', () {
    final api = TranslationApi();

    expect(api.translationService, isA<ITranslationService>());
    expect(api.transcriptionService, isA<ITranscriptionService>());
    expect(api.suggestionService, isA<ISuggestionService>());
  });
}
