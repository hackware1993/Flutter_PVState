import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_pvstate/pv_state.dart';

abstract class CounterPState extends BasePagePState<Stateful> {
  late int count;

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  void initState() {
    super.initState();
    count = widget.arguments!['initialCount'];
  }
}

class CounterVState extends CounterPState {
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
              '$count', // Direct access to count
              style: Theme.of(context).textTheme.headline4,
            ).applyConstraint(
              outBottomCenterTo: rId(0),
            ),
            FloatingActionButton(
              onPressed: add, // Widget and logic separation
              child: const Icon(Icons.add),
            ).applyConstraint(
              bottomRightTo: parent.rightMargin(20).bottomMargin(20),
            )
          ],
        ),
      ),
    );
  }
}
