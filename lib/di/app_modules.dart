import 'package:get_it/get_it.dart';
import 'package:receptom/data/cache/app_database.dart';
import 'package:receptom/data/cache/recipe/cache/recipe_local_impl.dart';
import 'package:receptom/data/cache/recipe/dao/recipe_dao.dart';
import 'package:receptom/data/cache/recipe/recipe_data_impl.dart';
import 'package:receptom/data/remote/chatgpt/chatgpt_data_impl.dart';
import 'package:receptom/data/remote/chatgpt/remote/chatgpt_remote_impl.dart';
import 'package:receptom/data/remote/network_client.dart';
import 'package:receptom/domain/chatgpt_repository.dart';
import 'package:receptom/domain/recipe_repository.dart';
import 'package:receptom/presentation/view/viewmodel/chatgpt_view_mode.dart';
import 'package:receptom/presentation/view/viewmodel/recipe_view_model.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupBDModule();
    _setupMainModule();
    _setupChatgptModule();
  }

  _setupMainModule() {
    inject.registerSingleton(NetworkClient());
  }

  _setupBDModule() {
    inject.registerSingletonAsync<AppDatabase>(() async =>
        $FloorAppDatabase.databaseBuilder('app_database.db').build());

    inject.registerSingletonWithDependencies<RecipeDao>(
        () => inject<AppDatabase>().recipeDao,
        dependsOn: [AppDatabase]);
  }

  _setupChatgptModule() {
    inject.registerFactory(() => ChatgptRemoteImpl(inject.get()));
    inject.registerFactory<ChatgptRepository>(
        () => ChatgptDataImpl(remoteImpl: inject.get()));
    inject
        .registerFactory<RecipeRepository>(() => RecipeDataImpl(inject.get()));
    inject.registerFactory(() => ChatgptViewModel(inject.get()));
    inject.registerFactory(() => RecipeViewModel(inject.get()));

    inject.registerFactory(() => RecipeLocalImpl(inject.get()));
  }
}
