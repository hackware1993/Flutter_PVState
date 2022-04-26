import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_pvstate/base.dart';

abstract class CounterPState extends BasePagePState {
  int count = 0;

  void add() {
    setState(() {
      count++;
    });
  }
}

class CountVState extends CounterPState with VState {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: ConstraintLayout(
          children: [
            const Text(
              'You have pushed the button this many times:',
            ).applyConstraint(
              centerTo: parent,
            ),
            Text(
              '$count', // Direct access to state
              style: Theme.of(context).textTheme.headline4,
            ).applyConstraint(
              outBottomCenterTo: rId(0),
            ),
            FloatingActionButton(
              onPressed: add, // Widget and logic separation
              child: const Icon(Icons.add),
            ).applyConstraint(
              bottomRightTo: parent,
              margin: const EdgeInsets.only(
                right: 20,
                bottom: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
