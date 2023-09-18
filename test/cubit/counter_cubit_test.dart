import 'package:bloc_counter/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // # group is a way to organize multiple tests of a feature, it contains multiple tests
  group('CounterCubit', () {
    late CounterCubit counterCubit;
    // # set up instantiate the objects that our tests will be working with, it is a function that is called to creates and initializes the necessary data
    setUp(() {
      counterCubit = CounterCubit();
    });

    // # tear down is a function that gets called after each test is run
    tearDown(() {
      counterCubit.close();
    });

    // # this test passes only because of equatable package
    test('the initial state for counterCubit is CounterState(counterValue:0)',
        () {
      expect(counterCubit.state, const CounterState(counterValue: 0));
    });

    // # using bloc test because we need to test the output as a response to our functions (increment and decrement in this case)

    // * testing increment method
    blocTest(
      'the cubit should emit a CounterState(counterValue:1 , wasIncremented: true) when cubit.increment() function is called',
      build: () =>
          counterCubit, // # returns the current instance of CounterCubit to make it available for testing process
      act: (cubit) => cubit
          .increment(), // # takes the cubit and return the action applied on it
      expect: () => [
        const CounterState(counterValue: 1, wasIncremented: true)
      ], // # iterable list which verifies if the order of the state and actual emitted state correspond with the emitted ones and no other
    );

    blocTest(
      'the cubit should emit a CounterState(counterValue:-1 , wasIncremented: false) when cubit.decrement() function is called',
      build: () => counterCubit, // # in short the init state
      act: (cubit) => cubit.decrement(), // # in short what it should do
      expect: () => [
        const CounterState(counterValue: -1, wasIncremented: false)
      ], // # in short the result
    );
  });
}
