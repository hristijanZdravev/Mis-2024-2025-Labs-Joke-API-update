import 'package:flutter/material.dart';
import 'package:joke_api_update/screens/favorite_joke.dart';
import 'package:joke_api_update/screens/random_joke.dart';
import 'package:joke_api_update/screens/jokes.dart';
import 'package:joke_api_update/services/api/joke_api_services.dart';
import 'package:joke_api_update/widgets/home/joke_type_card.dart';
import 'package:joke_api_update/models/joke_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final JokeApiService apiService = JokeApiService();
  late Future<List<String>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = apiService.fetchJokeTypes();
  }

  // Navigate to the JokesScreen with a particular joke type
  void _navigateToJokes(String jokeType) async {
    // Fetch jokes based on the selected type
    final jokes = await apiService.fetchJokesByType(jokeType);

    // Navigate to JokesScreen and pass the jokes and jokeType
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JokesScreen(
          jokeType: jokeType,
          jokes: jokes,
        ),
      ),
    );
  }

  // Navigate to the FavoriteJokeScreen
  void _navigateToFavoriteJokes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavoriteJokeScreen(),
      ),
    );
  }

  // Navigate to the RandomJokeScreen
  void _navigateToRandomJoke() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RandomJokeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes API 213255'),
        actions: [
          // Button to navigate to the FavoriteJokeScreen
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: _navigateToFavoriteJokes,
          ),
          // Button to navigate to the RandomJokeScreen
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: _navigateToRandomJoke,
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final types = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select a joke type:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        return JokeTypeCard(
                          jokeType: types[index],
                          onTap: () => _navigateToJokes(types[index]), // Navigate to specific joke type
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No joke types found.'));
          }
        },
      ),
    );
  }
}
