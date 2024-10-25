import 'package:flutter/material.dart';
import 'home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing Widget',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white60,
      ),
      debugShowCheckedModeBanner: false,
      home:  const Home(),
    );
  }
}




