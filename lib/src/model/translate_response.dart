class TranslateResponse {
  String taskType;
  List<Output> output;
  TranslateResponse({required this.output, required this.taskType});

  factory TranslateResponse.fromJson(Map<String, dynamic> map) {
    return TranslateResponse(
      output: (map["output"] as List)
          .map((item) => Output.fromJson(item))
          .toList(),
      taskType: map["taskType"],
    );
  }
}

class Output {
  String source;
  String target;
  Output({required this.source, required this.target});

  factory Output.fromJson(Map<String, dynamic> map) {
    return Output(source: map["source"], target: map["target"]);
  }
}
