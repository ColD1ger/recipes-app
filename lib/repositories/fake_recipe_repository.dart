import 'dart:math';

import 'package:recipeapp/model/recipe.dart';

class FakeRecipeRepository {
  final Random _random = Random();

  Future<List<Recipe>> fetchRecipes() async {
    await Future.delayed(const Duration(seconds: 2));

    if (_random.nextInt(3) == 0) {
      throw Exception('Չհաջողվեց բեռնել բաղադրատոմսերը։ Ստուգեք կապը։');
    }

    return mockRecipes;
  }
}
