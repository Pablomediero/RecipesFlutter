class Usage {
  final int completionTokens;
  final int promptTokens;
  final int totalTokens;

  Usage({
    required this.completionTokens,
    required this.promptTokens,
    required this.totalTokens,
  });

  factory Usage.fromMap(Map<String, dynamic> map) {
    return Usage(
      completionTokens: map['completion_tokens'] as int,
      promptTokens: map['prompt_tokens'] as int,
      totalTokens: map['total_tokens'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'completion_tokens': completionTokens,
      'prompt_tokens': promptTokens,
      'total_tokens': totalTokens,
    };
  }
}
