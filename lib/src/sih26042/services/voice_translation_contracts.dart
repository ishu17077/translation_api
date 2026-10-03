abstract class SpeechToTextEngine {
  Future<String> transcribe({
    required List<int> audioBytes,
    required String sourceLanguageCode,
  });
}

abstract class TextToSpeechEngine {
  Future<List<int>> synthesize({
    required String text,
    required String targetLanguageCode,
  });
}

class VoiceTranslationResult {
  final String transcriptInSourceLanguage;
  final String translatedText;
  final List<int>? synthesizedAudioBytes;

  const VoiceTranslationResult({
    required this.transcriptInSourceLanguage,
    required this.translatedText,
    this.synthesizedAudioBytes,
  });
}
