class VoiceResponse {
  String taskType;
  Output output;

  VoiceResponse({required this.taskType, required this.output});

  factory VoiceResponse.fromJson(Map<String, dynamic> map) {
    return VoiceResponse(
      taskType: map["taskType"],
      output: Output.fromJson(map["output"]),
    );
  }
}

class Output {
  String source;

  Output({required this.source});

  factory Output.fromJson(Map<String, dynamic> map) {
    return Output(source: map["source"]);
  }
}
