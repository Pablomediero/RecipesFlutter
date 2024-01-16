import 'package:floor/floor.dart';

@Entity(tableName: 'CacheRecipe')
class CacheRecipe {
  @PrimaryKey(autoGenerate: true)
  int? id;
  late String name;
  late String ingredients;
  late String instructions;
  late int serving;
  CacheRecipe(
      this.id, this.name, this.ingredients, this.instructions, this.serving);
}
