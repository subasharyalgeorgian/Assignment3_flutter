// jokes_page.dart

// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JokesPage extends StatefulWidget {
  const JokesPage({super.key});

  @override
  _JokesPageState createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  late Future<String> joke;

  @override
  void initState() {
    super.initState();
    joke = _fetchJoke();
  }

  Future<String> _fetchJoke() async {
    final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['value'];
    } else {
      throw Exception('Failed to load joke');
    }
  }

  void _getNextJoke() {
    setState(() {
      joke = _fetchJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes Page'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: joke,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data!,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _getNextJoke,
                    child: const Text('New Joke'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
