import 'package:receptom/data/remote/chatgpt/model/choices.dart';
import 'package:receptom/data/remote/chatgpt/model/usage.dart';

class ResponseChatgpt {
  final List<Choice> choices;
  final int created;
  final String id;
  final String model;
  final String object;
  final Usage usage;

  ResponseChatgpt({
    required this.choices,
    required this.created,
    required this.id,
    required this.model,
    required this.object,
    required this.usage,
  });

  factory ResponseChatgpt.fromMap(Map<String, dynamic> map) {
    return ResponseChatgpt(
      choices: (map['choices'] as List<dynamic>)
          .map((choice) => Choice.fromMap(choice))
          .toList(),
      created: map['created'] as int,
      id: map['id'] as String,
      model: map['model'] as String,
      object: map['object'] as String,
      usage: Usage.fromMap(map['usage']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'choices': choices.map((choice) => choice.toMap()).toList(),
      'created': created,
      'id': id,
      'model': model,
      'object': object,
      'usage': usage.toMap(),
    };
  }
}
