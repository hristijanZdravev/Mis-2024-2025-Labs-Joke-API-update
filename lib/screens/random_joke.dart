import 'package:flutter/material.dart';
import '../services/api/joke_api_services.dart';
import '../models/joke_model.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  State<RandomJokeScreen> createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  final JokeApiService apiService = JokeApiService();
  late Future<Joke> randomJoke;

  @override
  void initState() {
    super.initState();
    randomJoke = apiService.fetchRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke')),
      body: FutureBuilder<Joke>(
        future: randomJoke,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0), // Adjusted padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    joke.setup,
                    textAlign: TextAlign.center, // Centered text
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 2),
                  const SizedBox(height: 20),
                  Text(
                    joke.punchline,
                    textAlign: TextAlign.center, // Centered text
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No joke found.'));
          }
        },
      ),
    );
  }
}
