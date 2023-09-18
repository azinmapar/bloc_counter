import 'package:bloc_counter/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
          // # wrap with blocListener when we don't want a widget to rebuild

          // BlocListener<CounterCubit, CounterState>(
          //   listener: (context, state) {
          //     if (state.wasIncremented == true) {
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //         content: Text('Incremented'),
          //         duration: Duration(milliseconds: 100),
          //       ));
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //         content: Text('Decremented'),
          //         duration: Duration(milliseconds: 100),
          //       ));
          //     }
          //   },
          //   child:
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // # blocBuilder is for tracking changes in widgets
            // BlocBuilder<CounterCubit, CounterState>(
            //   builder: (context, state) {
            //     return
            // # a combination of blocBuilder and blocListener
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented'),
                    duration: Duration(milliseconds: 100),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented'),
                    duration: Duration(milliseconds: 100),
                  ));
                }
              },
              builder: (context, state) {
                return Text(
                  // # changing value
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            // },
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: '1',
                  onPressed: () {
                    // # first way of calling the function
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: '2',
                  onPressed: () {
                    // # second way of calling the function
                    context.read<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    // # change the name of the context so we don't confuse it with the main context
                    builder: (newContext) => BlocProvider.value(
                      value: context.read<CounterCubit>(),
                      child: const SecondScreen(
                        title: 'Second Screen',
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              },
              color: widget.color,
              child: const Text(
                'Go to Second Screen',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              color: widget.color,
              child: const Text(
                'Go to Third Screen',
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}

/* #
# Using Bloc For Anonymous Routing
# 1. Wrap the screen with BlocProvider.value
# 2. Give our Cubit to the value
! don't do CounterCubit(), this makes a new instance and defies the whole point
# 3. Pass the Cubit like this: 'BlocProvider.of<CounterCubit>(context)' or: 'context.read<CounterCubit>()'
! don't confuse our main context with the context that is given to the builder function in materialPageRoute, they have the same name so it's better if you change the second context
# */
