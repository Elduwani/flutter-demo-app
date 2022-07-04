import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class Box extends StatelessWidget {
  final String text;
  final bool revealed;
  final function;
  const Box({
    Key? key,
    required this.text,
    required this.revealed,
    required this.function,
  }) : super(key: key);

  void expose(index, count) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: revealed ? Colors.grey[100] : Colors.grey[300],
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

class Bomb extends StatelessWidget {
  final bool revealed;
  final function;
  const Bomb({
    Key? key,
    required this.revealed,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: revealed ? Colors.red : Colors.grey[700],
          child: const Center(
            child: Text(
              "x",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class Utils {
  void exposeNeighbors(
    int index,
    int rowCount,
    int gridCount,
    Function updater,
    List list,
  ) {
    List<int> indices = [];
    getHorizontalSquares(index, indices, rowCount);
    getHorizontalSquares(index + rowCount, indices, rowCount);
    getHorizontalSquares(index - rowCount, indices, rowCount);

    for (int i in indices) {
      //Important to avoid list overflow
      if (i >= 0 && i <= gridCount) {
        updater(i);
      }
    }
  }

  void scanBombs(
    List<int> bombLocations,
    int rowCount,
    int gridCount,
    Function updater,
  ) {
    List<int> indices = [];
    for (int index in bombLocations) {
      getHorizontalSquares(index, indices, rowCount);
      getHorizontalSquares(index + rowCount, indices, rowCount);
      getHorizontalSquares(index - rowCount, indices, rowCount);
    }

    for (int i in indices) {
      //Important to avoid list overflow
      if (i >= 0 && i <= gridCount) {
        updater(i);
      }
    }
  }

  void getHorizontalSquares(index, list, rowCount) {
    int mod = index % rowCount;
    list.add(index);
    if (mod != 0) {
      list.add(index - 1);
    }
    if (mod != rowCount - 1) {
      list.add(index + 1);
    }
  }
}
