import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

MyApp() {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
