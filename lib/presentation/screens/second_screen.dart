import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<SecondScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SecondScreen> {
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
                  onPressed: () {
                    // # first way of calling the function
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
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
              onPressed: () {},
              color: widget.color,
              child: const Text(
                'Go to Second Screen',
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
