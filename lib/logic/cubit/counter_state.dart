part of 'counter_cubit.dart';

// # this is the blueprint for all the possible states like getX controllers variables

class CounterState {
  // # variables to watch
  int counterValue;
  bool wasIncremented;

  // # constructor
  CounterState({required this.counterValue, this.wasIncremented = false});
}
