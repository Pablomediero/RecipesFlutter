import 'package:receptom/data/remote/chatgpt/model/request_body.dart';
import 'package:receptom/data/remote/const/network_const.dart';
import 'package:receptom/model/ingredient.dart';

class ChatgptRemoteMapper {
  static RequestBody toRemote(
      List<Ingredient> type, bool mode, String recipeName) {
    List<String> listToString =
        type.map((ingredient) => ingredient.name).toList();
    return RequestBody(
      model: NetworkConst.MODEL_OBJECT,
      prompt: mode
          ? "Necesito una receta, tengo como ingredientes ${listToString.join(",")}, devuélveme como resultado un formato JSON empezando directamente en llaves {} con el siguiente formato: "
              "{\"id\": 0,\"name\":\"Nombre receta\",\"ingredients\":[{\"id\":0,\"idRecipe\": 0,\"name\": \"Nombre de Ingrediente\"}],\"instructions\": \"Resultado preparación de la receta.\",\"serving\": numero de personas}\n"
              "Quiero que introduzcas todos los ingredientes que necesite la receta además de los que ya tengo, todos los campos id quiero que sean 0 y en una sola línea, que no existan saltos de línea."
          : "No quiero $recipeName, necesito otra receta distinta pero con los mismos ingredientes  ${listToString.join(",")}, devuelveme como resultado un formato JSON empezando la respuesta directamente desde el inicio de llaves ({}) sin caracteres previos, con el siguiente formato: "
              "{\"id\": 0,\"name\":\"Nombre receta\",\"ingredients\":[{\"id\":0,\"idRecipe\": 0,\"name\": \"Nombre de Ingrediente\"}],\"instructions\": \"Resultado preparación de la receta.\",\"serving\": numero de personas}\n"
              "Quiero que introduzcas todos los ingredientes que necesite la receta ademas de los que ya tengo, todos los campos id quiero que sean 0 y en una sola linea, que no existan saltos de linea",
      maxTokens: 1000,
      temperature: 0,
    );
  }
}
