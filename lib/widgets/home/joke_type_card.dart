import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;

  const JokeTypeCard({super.key, required this.jokeType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(20.0),
        title: Center(
          child: Text(
            jokeType.replaceFirst(
              jokeType[0],
              jokeType[0].toUpperCase(),
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}