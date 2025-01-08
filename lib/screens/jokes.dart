import 'package:flutter/material.dart';
import '../services/api/joke_api_services.dart';
import '../models/joke_model.dart';
import '../widgets/joke/joke_card.dart';
class JokesScreen extends StatefulWidget {
  final String jokeType;
  final List<Joke> jokes;

  const JokesScreen({super.key, required this.jokeType, required this.jokes});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jokeType} Jokes'),
      ),
      body: widget.jokes.isNotEmpty
          ? ListView.builder(
        itemCount: widget.jokes.length,
        itemBuilder: (context, index) {
          final joke = widget.jokes[index];
          return JokeCard(joke: joke);
        },
      )
          : const Center(child: Text('No jokes available.')),
    );
  }
}
