// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RecipeDao? _recipeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CacheRecipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `ingredients` TEXT NOT NULL, `instructions` TEXT NOT NULL, `serving` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RecipeDao get recipeDao {
    return _recipeDaoInstance ??= _$RecipeDao(database, changeListener);
  }
}

class _$RecipeDao extends RecipeDao {
  _$RecipeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cacheRecipeInsertionAdapter = InsertionAdapter(
            database,
            'CacheRecipe',
            (CacheRecipe item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'ingredients': item.ingredients,
                  'instructions': item.instructions,
                  'serving': item.serving
                }),
        _cacheRecipeDeletionAdapter = DeletionAdapter(
            database,
            'CacheRecipe',
            ['id'],
            (CacheRecipe item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'ingredients': item.ingredients,
                  'instructions': item.instructions,
                  'serving': item.serving
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CacheRecipe> _cacheRecipeInsertionAdapter;

  final DeletionAdapter<CacheRecipe> _cacheRecipeDeletionAdapter;

  @override
  Future<List<CacheRecipe>> getAllRecipes() async {
    return _queryAdapter.queryList('SELECT * FROM CacheRecipe',
        mapper: (Map<String, Object?> row) => CacheRecipe(
            row['id'] as int?,
            row['name'] as String,
            row['ingredients'] as String,
            row['instructions'] as String,
            row['serving'] as int));
  }

  @override
  Future<CacheRecipe?> getRecipe(int id) async {
    return _queryAdapter.query('SELECT * FROM CacheRecipe WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CacheRecipe(
            row['id'] as int?,
            row['name'] as String,
            row['ingredients'] as String,
            row['instructions'] as String,
            row['serving'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertRecipe(CacheRecipe recipe) async {
    await _cacheRecipeInsertionAdapter.insert(
        recipe, OnConflictStrategy.ignore);
  }

  @override
  Future<void> deleteRecipe(CacheRecipe recipe) async {
    await _cacheRecipeDeletionAdapter.delete(recipe);
  }
}
