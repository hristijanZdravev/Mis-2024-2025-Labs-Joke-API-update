import 'package:flutter/material.dart';
import '../../models/joke_model.dart';
import '../../services/favorite_joke_service.dart'; // Import the service

class JokeCard extends StatefulWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Check if the joke is in the favorites list when the widget is initialized
    isFavorite = FavoriteJokesService.instance.isFavorite(widget.joke);
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite; // Toggle the favorite state
    });
    FavoriteJokesService.instance.toggleFavorite(widget.joke); // Add or remove joke from favorites
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.joke.setup,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              widget.joke.punchline,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: _toggleFavorite, // Call _toggleFavorite to add/remove from favorites
            ),
          ],
        ),
      ),
    );
  }
}
