import 'dart:io';

import 'package:flutter/material.dart';
import 'dayNightSwitch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // title: Row(
          //   children: [
          //     // dayNightSwitch(),
          //     InkWell(
          //       onTap: (() {
          //         setState(() {});
          //       }),
          //       child: _switchMode(),
          //     ),
          //     SizedBox(width: 60),
          //     Text("Tic - Tac - Toe"),
          //   ],
          // ),
          title: const Text(
            "Tic - Tac - Toe",
            style: TextStyle(fontSize: 40),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          toolbarHeight: 90,
        ),

        // BODY

        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // main body with the board
            boardBuilder(),
          ],
        ),
      ),
    );
  }
}

class boardBuilder extends StatefulWidget {
  const boardBuilder({super.key});

  @override
  State<boardBuilder> createState() => _boardBuilderState();
}

class _boardBuilderState extends State<boardBuilder> {
  // list
  List tileContent = ["", "", "", "", "", "", "", "", ""];
  int turn = 0;
  List victory = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];
  List checked = [];
  List theExes = [];
  List theOhs = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          25, MediaQuery.of(context).size.height / 5, 25, 0),
      child: GridView.count(
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        crossAxisCount: 3,
        children: [
          for (int i = 0; i < 9; i++)
            InkWell(
              onTap: () {
                setState(() {
                  if (checked.contains(i)) {
                    print("");
                  } else {
                    _tileTappedText(i, turn);
                    checked.add(i);
                    turn++;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    tileContent[i],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _tileTappedText(int i, int turn) {
    if (turn % 2 == 0) {
      tileContent[i] = "X";
      theExes.add(i);
    } else {
      tileContent[i] = "O";
      theOhs.add(i);
    }
    _checkForWin();
  }

  void _checkForWin() {
    String victor = "No one yet";

    if (tileContent[0] == tileContent[1] &&
        tileContent[1] == tileContent[2] &&
        tileContent[2] != "") {
      victor = tileContent[0] + " Wins!";
      _showDialog(victor);
    } else if (tileContent[3] == tileContent[4] &&
        tileContent[4] == tileContent[5] &&
        tileContent[5] != "") {
      victor = tileContent[3] + " Wins!";
      _showDialog(victor);
    } else if (tileContent[6] == tileContent[7] &&
        tileContent[7] == tileContent[8] &&
        tileContent[8] != "") {
      victor = tileContent[6] + " Wins!";
      _showDialog(victor);
    } else if (tileContent[0] == tileContent[3] &&
        tileContent[3] == tileContent[6] &&
        tileContent[6] != "") {
      victor = tileContent[0] + " Wins!";
      _showDialog(victor);
    } else if (tileContent[1] == tileContent[4] &&
        tileContent[4] == tileContent[7] &&
        tileContent[7] != "") {
      victor = tileContent[1] + " Wins!";
      _showDialog(victor);
    } else if (tileContent[2] == tileContent[5] &&
        tileContent[5] == tileContent[8] &&
        tileContent[8] != "") {
      victor = tileContent[2] + " Wins!";
      _showDialog(victor);
    } else if (tileContent[0] == tileContent[4] &&
        tileContent[4] == tileContent[8] &&
        tileContent[8] != "") {
      victor = tileContent[0] + " Wins!";
      _showDialog(victor);
    } else if (tileContent[2] == tileContent[4] &&
        tileContent[4] == tileContent[6] &&
        tileContent[6] != "") {
      victor = tileContent[2] + " Wins!";
      _showDialog(victor);
    }
    if (checked.length == 8 && victor == "No one yet") {
      victor = "It's a draw!";
      _showDialog(victor);
    }
    print(victor);
  }

  void _showDialog(String victor) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Center(
                child: Text(
                  victor,
                  style: const TextStyle(
                    fontSize: 40,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      checked = [];
                      theExes = [];
                      theOhs = [];
                      tileContent = ["", "", "", "", "", "", "", "", ""];
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text(
                    "Play Again",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

// NOT IMPLEMENTED -> DAY AND NIGHT MODE SWITCH
class _switchMode extends StatefulWidget {
  const _switchMode({super.key});

  @override
  State<_switchMode> createState() => __switchModeState();
}

//
String backgroundImage = "assets/sunsetBackground.jpg";
String currentMode = "day";
//

class __switchModeState extends State<_switchMode> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        File myfile = File("preferences.txt");
        String curMode = myfile.readAsStringSync();

        setState(() {
          currentMode = curMode;
          if (currentMode == "day") {
            backgroundImage = "assets/nightBackground.jpg";
            myfile.writeAsStringSync("night");
          } else if (currentMode == "night") {
            backgroundImage = "assets/sunsetBackground.jpg";
            myfile.writeAsStringSync("day");
          }
        });
      },
      child: Container(
        width: 75,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 3, color: Colors.white),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
