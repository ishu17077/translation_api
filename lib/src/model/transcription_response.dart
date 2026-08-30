class TranscriptionResponse {
  final String taskType;
  final TranscriptionOutput output;

  const TranscriptionResponse({required this.taskType, required this.output});

  factory TranscriptionResponse.fromJson(Map<String, dynamic> map) {
    return TranscriptionResponse(
      taskType: map["taskType"],
      output: TranscriptionOutput.fromJson(map["output"]),
    );
  }
}

class TranscriptionOutput {
  String source;

  TranscriptionOutput({required this.source});

  factory TranscriptionOutput.fromJson(Map<String, dynamic> map) {
    return TranscriptionOutput(source: map["source"]);
  }
}
