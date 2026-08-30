class VoicePayload {
  String sourceLanguage;
  String audioContent;
  int samplingRate;
  String task;
  String domain;
  String serviceId;

  VoicePayload({
    required this.sourceLanguage,
    required this.audioContent,
    required this.domain,
    required this.samplingRate,
    required this.serviceId,
    required this.task,
  });

  Map<String, dynamic> toJson() => {
    "sourceLanguage": sourceLanguage,
    "audioContent": audioContent,
    "samplingRate": samplingRate,
    "serviceId": serviceId,
    "task": task,
  };
}
