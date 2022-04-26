# flutter_pvstate

Extremely lightweight state management framework in only 120 lines of code.

Direct access to state is the red line that cannot be compromised, not controller.something.

## Getting Started

![effect.gif](https://github.com/hackware1993/Flutter_PVState/blob/master/effect.gif?raw=true)

```dart
void main() {
  runApp(Stateful(state: CountVState()));
}

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
```
