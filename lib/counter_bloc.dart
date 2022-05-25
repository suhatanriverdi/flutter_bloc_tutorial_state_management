import 'dart:async';

enum CounterAction { increment, decrement, reset }

class CounterBloc {
  int _counter = 0;

  // State Stream Controller
  final _stateStreamController = StreamController<int>();
  // Input
  StreamSink<int> get counterSink => _stateStreamController.sink;
  // Output
  Stream<int> get counterStream => _stateStreamController.stream;

  // Event Stream Controller
  final _eventStreamController = StreamController<CounterAction>();
  // Input
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  // Output
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    eventStream.listen((event) {
      if (event == CounterAction.increment) {
        _counter++;
      } else if (event == CounterAction.decrement) {
        _counter--;
      } else if (event == CounterAction.reset) {
        _counter = 0;
      }

      counterSink.add(_counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
