import 'dart:collection';
import 'dart:math';
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
            child: Text(
              revealed ? (text != "0" ? text : "") : "",
              style: TextStyle(
                color: text == "1"
                    ? Colors.green
                    : text == "2"
                        ? Colors.blue
                        : Colors.red,
              ),
            ),
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
          color: revealed ? Colors.red[700] : Colors.grey[300],
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
    int mod = index % rowCount;
    //Reveal current box
    updater(index);

    void recurse(int i) {
      exposeNeighbors(i, rowCount, gridCount, updater, list);
    }

    if (list[index][0] == 0) {
      //Recurse left until the left wall
      if (mod != 0) {
        if (list[index - 1][0] == 0 && list[index - 1][1] == false) {
          recurse(index - 1);
        }
        updater(index - 1);
      }

      //Recurse right until the right wall
      //We have to (at least) be on the second to last box for this
      if (mod != rowCount - 1) {
        if (list[index + 1][0] == 0 && list[index + 1][1] == false) {
          recurse(index + 1);
        }
        updater(index + 1);
      }

      // Recurse top row unless until the bottom wall
      // We have to (at least) somewhere for this
      if (index >= rowCount) {
        if (list[index - rowCount][0] == 0 &&
            list[index - rowCount][1] == false) {
          recurse(index - rowCount);
        }
        updater(index - rowCount);
      }

      // Recurse bottom row unless until the bottom wall
      // We have to (at least) somewhere for this
      if (index < gridCount - rowCount) {
        if (list[index + rowCount][0] == 0 &&
            list[index + rowCount][1] == false) {
          recurse(index + rowCount);
        }
        updater(index + rowCount);
      }

      //Recurse top left row unless until the left wall
      //We have to (at least) be on the second row for this
      if (mod != 0 && index >= rowCount) {
        if (list[index - 1 - rowCount][0] == 0 &&
            list[index - 1 - rowCount][1] == false) {
          recurse(index - 1 - rowCount);
        }
        updater(index - 1 - rowCount);
      }

      //Recurse bottom right row unless until the bottom wall | right wall
      //We have to (at least) somewhere for this
      if (index < gridCount - rowCount && mod != rowCount - 1) {
        if (list[index + 1 + rowCount][0] == 0 &&
            list[index + 1 + rowCount][1] == false) {
          recurse(index + 1 + rowCount);
        }
        updater(index + 1 + rowCount);
      }
    }
  }

  void scanBombs(
      List<int> bombLocations, int rowCount, int gridCount, Function updater) {
    List<int> indices = [];
    for (int index in bombLocations) {
      getHorizontalSquares(index, indices, rowCount);
      getHorizontalSquares(index + rowCount, indices, rowCount);
      getHorizontalSquares(index - rowCount, indices, rowCount);
    }

    for (int i in indices) {
      //Important to avoid list overflow
      if (i >= 0 && i <= gridCount - 1) {
        updater(i);
      }
    }
  }

  void getHorizontalSquares(index, list, rowCount) {
    int mod = index % rowCount;
    // devtools.log(list[index].toString());
    list.add(index);
    if (mod != 0) {
      list.add(index - 1);
    }
    if (mod != rowCount - 1) {
      list.add(index + 1);
    }
  }

  List<int> randomNumbers(
      {int min = 0, required int max, required int listCount}) {
    final hash = HashSet();
    List<int> list = [];

    for (int i = 0; i < max; i++) {
      final n = Random().nextInt(max);
      if (hash.contains(n)) {
        i--;
        continue;
      }
      hash.add(n);
      list.add(n);

      if (list.length >= listCount) {
        //Return early
        // devtools.log(list.toString());
        // return list;
      }
    }

    list.shuffle();
    return list.sublist(0, listCount);
  }
}
