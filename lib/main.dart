import 'package:flutter/material.dart';
import 'package:mobile_app_assignment_3/screens/home_screen.dart';
import 'home_screen.dart'; // Import your HomeScreen
import 'databases/database_helper.dart'; // Import DatabaseHelper

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures the app is initialized before calling async methods
  await DatabaseHelper.initialize(); // Initialize the database
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
