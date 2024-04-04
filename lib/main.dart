import 'package:flutter/material.dart';
import 'package:flutter_app01/models/quote.dart';
import 'package:flutter_app01/pages/lading_page.dart';

void main() async {
  await Quotes().getAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
