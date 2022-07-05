import 'package:demo_app/utils/mine_sweeper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:developer' as devtools show log;

import '../components/input.dart';

class MineSweeper extends StatefulWidget {
  const MineSweeper({Key? key}) : super(key: key);

  @override
  State<MineSweeper> createState() => _MineSweeperState();
}

class _MineSweeperState extends State<MineSweeper> {
  static const _unit = 8.0;
  static const bombCount = 6;
  static const rowCount = 9;
  static const gridCount = rowCount * rowCount;

  List squareStatus = [];
  List<int> bombLocations = [];
  bool gameEnded = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < gridCount; i++) {
      squareStatus.add([0, false]);
    }
    bombLocations = Utils().randomNumbers(
      max: gridCount,
      listCount: bombCount,
    );

    Utils().scanBombs(
      bombLocations,
      rowCount,
      gridCount,
      (int i) => squareStatus[i][0]++,
    );
  }

  void revealBox(int index) {
    // if (!gameEnded) {
    void updater(int i) {
      setState(() {
        squareStatus[i][1] = true;
      });
    }

    Utils().exposeNeighbors(
      index,
      rowCount,
      gridCount,
      updater,
      squareStatus,
    );
    // }
  }

  void detonate() {
    setState(() {
      gameEnded = true;
      for (int i in bombLocations) {
        squareStatus[i][1] = true;
      }
    });
  }

  void reset() {
    setState(() {
      gameEnded = false;
      for (int i = 0; i < gridCount; i++) {
        squareStatus[i][1] = false;
        squareStatus[i][0] = 0;
      }
      bombLocations = Utils().randomNumbers(
        max: gridCount,
        listCount: bombCount,
      );
      Utils().scanBombs(
        bombLocations,
        rowCount,
        gridCount,
        (int i) => squareStatus[i][0]++,
      );
    });
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bombCount.toString(),
                    style: const TextStyle(fontSize: 40),
                  ),
                  const Text(
                    "BOMBS",
                    style: TextStyle(letterSpacing: _unit),
                  ),
                ],
              ),
              GestureDetector(
                onTap: reset,
                child: Card(
                  color: Colors.grey[700],
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("0", style: TextStyle(fontSize: 40)),
                  Text("TIME", style: TextStyle(letterSpacing: _unit)),
                ],
              ),
            ],
          ),
        ),

        //Grid
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowCount,
            ),
            itemBuilder: (context, index) {
              if (bombLocations.contains(index)) {
                return Bomb(
                  revealed: squareStatus[index][1],
                  function: detonate,
                );
              }
              return Box(
                text: squareStatus[index][0].toString(),
                revealed: squareStatus[index][1],
                function: () => revealBox(index),
              );
            },
          ),
        ),
        const Center(
          child: Text("Quantic Labs"),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${FirebaseAuth.instance.currentUser?.email}",
                style: TextStyle(
                  fontSize: _unit * 1.2,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: _unit * 2),
              Button(
                function: signOut,
                text: "Sign Out",
                color: Colors.grey[900],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
