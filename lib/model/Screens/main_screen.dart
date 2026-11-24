import 'package:flutter/material.dart';
import 'package:recipeapp/model/recipe.dart';
import 'package:recipeapp/repositories/fake_recipe_repository.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final FakeRecipeRepository _repository = FakeRecipeRepository();
  late Future<List<Recipe>> _recipesFuture;

  String _selectedDifficulty = 'Բոլորը';
  final List<String> _filters = ['Բոլորը', 'Easy', 'Medium'];

  @override
  void initState() {
    super.initState();
    _recipesFuture = _repository.fetchRecipes();
  }

  Future<void> _reloadRecipes() async {
    setState(() {
      _recipesFuture = _repository.fetchRecipes();
    });
    await _recipesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Բաղադրատոմսեր'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Սխալ տեղի ունեցավ.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reloadRecipes,
                      child: const Text('Կրկին փորձել'),
                    ),
                  ],
                ),
              ),
            );
          }

          final allRecipes = snapshot.data ?? [];

          if (allRecipes.isEmpty) {
            return const Center(
              child: Text(
                'Բաղադրատոմսեր չկան',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final filteredRecipes = _selectedDifficulty == 'Բոլորը'
              ? allRecipes
              : allRecipes
                  .where((recipe) => recipe.difficulty == _selectedDifficulty)
                  .toList();

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _filters.map((filter) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: _selectedDifficulty == filter,
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              _selectedDifficulty = filter;
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _reloadRecipes,
                  child: filteredRecipes.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 100),
                            Center(
                                child: Text('Այս ֆիլտրով բաղադրատոմսեր չկան')),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = filteredRecipes[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              child: ListTile(
                                title: Text(
                                  recipe.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${recipe.cuisine} • ${recipe.cookTimeMinutes} րոպե • ${recipe.difficulty}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 20),
                                    const SizedBox(width: 4),
                                    Text(
                                      recipe.rating.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
