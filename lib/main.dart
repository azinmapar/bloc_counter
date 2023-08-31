import 'package:bloc_counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // # wrap with blocProvider<CounterCubit> that returns CounterCubit
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            )
          ],
        ),
      ),
      // ),
    );
  }
}

/* #
/ # step 1: create a cubit folder and in it two files for state and cubit
/ # step 2: explained in [CounterState] class
/ # step 3: explained in [CounterCubit] class
/ # step 4: wrap the MaterialApp with blocProvider
/ # step 5: blocProvider type is our Cubit in <> and returns our Cubit
/ # step 6: call those functions in Cubit in onPressed
/ # step 7: wrap the widget that is changing in BlocProvider
/ # step 8: blocListener doesn't rebuild its widget, it starts listening to changes in the state and when a change happens it does what it returns and this is the difference between this and blocProvider
/ # step 9: combining blocProvider and blocListener into blocConsumer
# */

/* #
/ # tip: buildWhen and listenWhen can make exceptions for building and listening
/ # tip2: there is a multiBloc Listener and provider that they can multiple cubits and blocs
# */
