import 'package:demo_app/utils/mine_sweeper.dart';
import 'package:flutter/material.dart';

class MineSweeper extends StatefulWidget {
  const MineSweeper({Key? key}) : super(key: key);

  @override
  State<MineSweeper> createState() => _MineSweeperState();
}

class _MineSweeperState extends State<MineSweeper> {
  static const _unit = 8.0;
  static const rowCount = 9;
  static const gridCount = rowCount * rowCount;

  List squareStatus = [];
  List<int> bombLocations = [4, 20, 40, 55];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < gridCount; i++) {
      squareStatus.add([0, false]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    Text("6", style: TextStyle(fontSize: 40)),
                    const Text("BOMBS", style: TextStyle(letterSpacing: _unit)),
                  ],
                ),
                Card(
                  color: Colors.grey[700],
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("0", style: TextStyle(fontSize: 40)),
                    const Text("TIME", style: TextStyle(letterSpacing: _unit)),
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
                  return Bomb(text: index.toString());
                }
                return Box(text: index.toString());
              },
            ),
          )
        ],
      ),
    );
  }
}