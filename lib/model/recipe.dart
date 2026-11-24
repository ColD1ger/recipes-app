class Recipe {
  final String id;
  final String name;
  final String cuisine;
  final int cookTimeMinutes;
  final String difficulty; // 'Easy', 'Medium', 'Hard'
  final double rating;

  const Recipe({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.rating,
  });
}

const List<Recipe> mockRecipes = [
  Recipe(
    id: '1',
    name: 'Խորոված',
    cuisine: 'Հայկական',
    cookTimeMinutes: 45,
    difficulty: 'Medium',
    rating: 4.9,
  ),
  Recipe(
    id: '2',
    name: 'Կեսար աղցան',
    cuisine: 'Միջազգային',
    cookTimeMinutes: 15,
    difficulty: 'Easy',
    rating: 4.5,
  ),
  Recipe(
    id: '3',
    name: 'Սպաս',
    cuisine: 'Հայկական',
    cookTimeMinutes: 30,
    difficulty: 'Easy',
    rating: 4.8,
  ),
  Recipe(
    id: '4',
    name: 'Կարբոնարա',
    cuisine: 'Իտալական',
    cookTimeMinutes: 25,
    difficulty: 'Medium',
    rating: 4.7,
  ),
  Recipe(
    id: '5',
    name: 'Տոլմա',
    cuisine: 'Հայկական',
    cookTimeMinutes: 60,
    difficulty: 'Hard',
    rating: 5.0,
  ),
  Recipe(
    id: '6',
    name: 'Բրուսկետա',
    cuisine: 'Իտալական',
    cookTimeMinutes: 10,
    difficulty: 'Easy',
    rating: 4.4,
  ),
];
