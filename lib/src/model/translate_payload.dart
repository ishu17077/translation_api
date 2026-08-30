class TranslatePayload {
  String sourceLanguage;
  String targetLanguage;
  String input;
  String task;
  String serviceId;
  bool track;
  TranslatePayload({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.input,
    required this.task,
    required this.serviceId,
    required this.track,
  });

  Map<String, dynamic> toJson() => {
    "sourceLanguage": sourceLanguage,
    "targetLanguage": targetLanguage,
    "input": input,
    "task": task,
    "serviceId": serviceId,
    "track": track,
  };

}
