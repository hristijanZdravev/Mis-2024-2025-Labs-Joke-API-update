import '../models/joke_model.dart';

class FavoriteJokesService {
  static final FavoriteJokesService _instance = FavoriteJokesService._internal();
  factory FavoriteJokesService() => _instance;

  FavoriteJokesService._internal();

  final List<Joke> favoriteJokes = [];

  // Singleton instance
  static FavoriteJokesService get instance => _instance;

  // Add or remove joke from favorites
  void toggleFavorite(Joke joke) {
    if (favoriteJokes.contains(joke)) {
      favoriteJokes.remove(joke); // If joke is already in favorites, remove it
    } else {
      favoriteJokes.add(joke); // If not, add it to favorites
    }
  }

  // Check if a joke is in favorites
  bool isFavorite(Joke joke) {
    return favoriteJokes.contains(joke);
  }
}
