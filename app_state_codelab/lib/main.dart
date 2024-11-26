import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// For app state, the counter state is shared globally and accessible across widgets.


void main() => runApp(MyApp());

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final CounterModel model = CounterModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Scoped Model Example')),
          body: CounterWidget(),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter Value: ${model.counter}'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                model.increment();
              },
              child: Text('Increment'),
            ),
            SizedBox(height: 20), // Added padding between increment and decrement
            ElevatedButton(
              onPressed: () {
                model.decrement();
              },
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}