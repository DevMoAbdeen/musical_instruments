import 'package:flutter/material.dart';
import 'package:musical_instruments/all_instruments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllMusicalInstruments(),
    );
  }
}
