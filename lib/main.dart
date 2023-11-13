import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:notifications/search.dart';
import 'package:notifications/titles.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Anchor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  late final SearchController searchController;

  MyHomePage({
    super.key,
  }) {
    searchController = SearchController();
  }

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Titles resultData = Titles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: SearchComponent(
          searchController: widget.searchController,
          resultData: resultData,
          fetchDataFromBackend: fetchDataFromBackend,
        ),
      ),
      body: const Center(
        child: Text('Search Anchor'),
      ),
    );
  }
}

//Request
Future<List<String>> fetchDataFromBackend(String text) async {
  final result =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  final jsonResponse = json.decode(result.body) as List;

  List<String> titles = jsonResponse
      .whereType<Map<String, dynamic>>()
      .map<String>((item) => item["name"] as String)
      .where((title) => title
          .toLowerCase()
          .contains(text.toLowerCase())) // Remove títulos vazios
      .toList();

  return titles;
}
