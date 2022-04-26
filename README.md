# Flutter_PVState

Extremely lightweight state management framework in only 120 lines of code.

Direct access to state is the bottom line, indirect access such as controller.something is
completely unacceptable.

## Getting Started

![effect.gif](https://github.com/hackware1993/Flutter_PVState/blob/master/effect.gif?raw=true)

```dart
void main() {
  runApp(Stateful.of(CounterVState()));
}

import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_pvstate/pv_state.dart';

/// Presenter state, logic is written here
abstract class CounterPState extends BasePagePState {
  final count = obs(0);

  void add() {
    count.value = count.value + 1;
  }

// int count = 0;
//
// void add() {
//   setState(() {
//     count++;
//   });
// }
}

/// View state, view is written here
class CounterVState extends CounterPState with VState {
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

            /// Local update
            ValueListenableBuilder(
              valueListenable: count,
              builder: (_, value, __) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ).applyConstraint(
              outBottomCenterTo: rId(0),
            ),

            /// Global update
            // Text(
            //   '$count', // Direct access to count
            //   style: Theme.of(context).textTheme.headline4,
            // ).applyConstraint(
            //   outBottomCenterTo: rId(0),
            // ),

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
```
