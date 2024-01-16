import 'dart:async';

import 'package:receptom/domain/chatgpt_repository.dart';
import 'package:receptom/model/order.dart';
import 'package:receptom/model/recipe.dart';
import 'package:receptom/presentation/base/base_view_model.dart';
import 'package:receptom/presentation/model/resource_state.dart';

class ChatgptViewModel extends BaseViewModel {
  final ChatgptRepository _chatgptRepository;

  final StreamController<ResourceState<Recipe>> getChatgptResponseState =
      StreamController.broadcast();

  ChatgptViewModel(this._chatgptRepository);

  fetchRecipeChatgpt(Order order) {
    getChatgptResponseState.add(ResourceState.loading());

    _chatgptRepository
        .getChatResponse(order)
        .then((value) =>
            getChatgptResponseState.add(ResourceState.success(value)))
        .catchError(
            (error) => getChatgptResponseState.add(ResourceState.error(error)));
  }

  @override
  void dispose() {
    getChatgptResponseState.close();
  }
}
