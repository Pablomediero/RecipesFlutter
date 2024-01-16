class RequestBody {
  String model;
  String prompt;
  int maxTokens;
  int temperature;

  RequestBody({
    required this.model,
    required this.prompt,
    required this.maxTokens,
    required this.temperature,
  });

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'prompt': prompt,
      'maxTokens': maxTokens,
      'temperature': temperature,
    };
  }
}
