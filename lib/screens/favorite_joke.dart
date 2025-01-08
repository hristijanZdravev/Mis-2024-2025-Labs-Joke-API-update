import 'package:flutter/material.dart';
import '../../services/favorite_joke_service.dart';
import '../models/joke_model.dart';

class FavoriteJokeScreen extends StatefulWidget {
  const FavoriteJokeScreen({super.key});

  @override
  State<FavoriteJokeScreen> createState() => _FavoriteJokeScreenState();
}

class _FavoriteJokeScreenState extends State<FavoriteJokeScreen> {
  late List<Joke> favoriteJokes;

  @override
  void initState() {
    super.initState();
    // Get the favorite jokes from the FavoriteJokesService
    favoriteJokes = FavoriteJokesService.instance.favoriteJokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text('No favorite jokes yet.'))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(joke.setup),
              subtitle: Text(joke.punchline),
            ),
          );
        },
      ),
    );
  }
}
