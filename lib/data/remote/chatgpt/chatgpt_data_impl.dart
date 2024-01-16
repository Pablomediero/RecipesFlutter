import 'package:receptom/data/remote/chatgpt/remote/chatgpt_remote_impl.dart';
import 'package:receptom/domain/chatgpt_repository.dart';
import 'package:receptom/model/order.dart';
import 'package:receptom/model/recipe.dart';

class ChatgptDataImpl extends ChatgptRepository {
  final ChatgptRemoteImpl _remoteImpl;

  ChatgptDataImpl({required ChatgptRemoteImpl remoteImpl})
      : _remoteImpl = remoteImpl;

  @override
  Future<Recipe> getChatResponse(Order order) async {
    final remoteAnswer = await _remoteImpl.getChatResponse(order);
    return remoteAnswer;
  }
}
