import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:receptom/data/remote/chatgpt/mapper/chatpgt_remote_mapper.dart';
import 'package:receptom/data/remote/const/network_const.dart';
import 'package:receptom/data/remote/error/remote_error_mapper.dart';
import 'package:receptom/data/remote/network_client.dart';
import 'package:receptom/model/order.dart';
import 'package:receptom/model/recipe.dart';

class ChatgptRemoteImpl {
  final NetworkClient _networkClient;

  ChatgptRemoteImpl(this._networkClient);

  @override
  Future<Recipe> getChatResponse(Order order) async {
    try {
      final requestBody = ChatgptRemoteMapper.toRemote(
          order.ingredients, order.mode, order.recipeName);
      final response = await _networkClient.dio.post(
        NetworkConst.BASE_URL,
        data: {
          'model': requestBody.model,
          'prompt': requestBody.prompt,
          'max_tokens': requestBody.maxTokens,
          'temperature': requestBody.temperature
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${NetworkConst.API_KEY}',
        }),
      );

      if (response.statusCode == 200) {
        String jsonRecipeString = response.data['choices'][0]['text'];
        Map<String, dynamic> jsonMap = json.decode(jsonRecipeString);
        Recipe recipe = Recipe.fromJson(jsonMap);

        return recipe;
      } else {
        throw Exception('Request failed with status ${response.statusCode}');
      }
    } catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }
}
