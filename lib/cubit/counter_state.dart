part of 'counter_cubit.dart';

// # this is the blueprint for all the possible states like getX controllers variables

class CounterState extends Equatable {
  // # variables to watch
  final int counterValue;
  final bool wasIncremented;

  // # constructor
  const CounterState({required this.counterValue, this.wasIncremented = false});

  // # which instances should be compared
  @override
  List<Object?> get props => [counterValue, wasIncremented];
}
