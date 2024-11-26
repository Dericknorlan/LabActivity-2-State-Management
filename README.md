# Flutter State Management Codelab

This repository contains two projects demonstrating different approaches to state management in Flutter:

1. **Ephemeral State Management** using `StatefulWidget` in the `ephemeral_state_codelab` folder.
2. **App State Management** using the `scoped_model` package in the `app_state_codelab` folder.

## Objectives

- Understand **Ephemeral State Management** for local widget-specific state.
- Explore **App State Management** to handle app-wide state efficiently.
- Compare the two approaches and learn when to use each.

---

## Projects Overview

### 1. **Ephemeral State Management (ephemeral_state_codelab)**

This project demonstrates state management tied to a single widget using `StatefulWidget`.  
The counter value is updated locally and is not shared across widgets or screens.

#### Key Features:
- Uses `StatefulWidget` for state changes.
- Simple implementation for localized state.
- Suitable for scenarios where state does not need to be shared.

#### Code Highlights:
```dart
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter Value: $_counter'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
