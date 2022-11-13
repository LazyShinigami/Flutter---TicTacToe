import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

File preferences = File('preferences.txt');

class dayNightSwitch extends StatefulWidget {
  const dayNightSwitch({super.key});

  @override
  State<dayNightSwitch> createState() => _dayNightSwitchState();
}

class _dayNightSwitchState extends State<dayNightSwitch> {
  String currentMode = preferences.readAsStringSync();
  String backgroundImage = "";

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          if (currentMode == "day") {
            backgroundImage = "assets/nightBackground.jpg";
            currentMode = "night";
            preferences.writeAsStringSync(currentMode);
          } else {
            backgroundImage = "assets/sunsetBackground.jpg";
            currentMode = "day";
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(75),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        height: 50,
        width: 80,
      ),
    );
  }
}
