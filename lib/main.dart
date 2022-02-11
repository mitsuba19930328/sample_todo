// main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List App',
      debugShowCheckedModeBanner: true,
      color: Colors.greenAccent, //好きな色を選択
      home: HomePage(),
    );
  }
}