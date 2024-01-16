class Choice {
  final String finishReason;
  final int index;
  final dynamic logprobs;
  final String text;

  Choice({
    required this.finishReason,
    required this.index,
    required this.logprobs,
    required this.text,
  });

  factory Choice.fromMap(Map<String, dynamic> map) {
    return Choice(
      finishReason: map['finish_reason'] as String,
      index: map['index'] as int,
      logprobs: map['logprobs'],
      text: map['text'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'finish_reason': finishReason,
      'index': index,
      'logprobs': logprobs,
      'text': text,
    };
  }
}
