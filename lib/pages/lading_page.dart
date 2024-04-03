import 'package:flutter/material.dart';
import 'package:flutter_app01/values/app_assets.dart';
import 'package:flutter_app01/values/app_colors.dart';
import 'package:flutter_app01/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Container(
          color: Colors.red,
        )),
        Expanded(
            child: Container(
          color: Colors.blue,
        )),
        Expanded(
            child: Container(
          color: Colors.green,
        )),
      ]),
    );
  }
}
