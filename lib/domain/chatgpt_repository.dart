import 'package:receptom/model/order.dart';
import 'package:receptom/model/recipe.dart';

abstract class ChatgptRepository {
  Future<Recipe> getChatResponse(Order order);
}
