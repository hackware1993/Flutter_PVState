# Flutter_PVState

Extremely lightweight state management framework in only 120 lines of code.

Direct access to state is the bottom line, indirect access such as controller.something is
completely unacceptable.

**I have developed the world's fastest general purpose sorting algorithm, which is on average 3 times faster than Quicksort and up to 20 times faster**, [ChenSort](https://github.com/hackware1993/ChenSort)

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
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
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

# License

```
MIT License

Copyright (c) 2022 hackware1993

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
