import 'package:flutter_test/flutter_test.dart';
import 'package:translation_api/translation_api.dart';

void main() {
  test('TranscriptionResponse parses API payload correctly', () {
    final response = TranscriptionResponse.fromJson(
      <String, dynamic>{
        'taskType': 'asr',
        'output': <Map<String, String>>[
          <String, String>{'source': 'यह एक परीक्षण है'},
        ],
      },
    );

    expect(response.taskType, 'asr');
    expect(response.output, hasLength(1));
    expect(response.output.first.source, 'यह एक परीक्षण है');
  });
}
