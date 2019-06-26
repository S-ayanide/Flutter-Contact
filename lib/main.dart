import 'package:flutter/material.dart';
import 'Screens/HomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Contact",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.green,
        primarySwatch: Colors.green,
        accentColor: Colors.green 
      ),
      home: HomePage(),
    );
  }
}

void main() => runApp(MyApp());