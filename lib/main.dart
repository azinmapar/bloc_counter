import 'package:bloc_counter/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // # wrap with blocProvider<CounterCubit> that returns CounterCubit
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: const HomeScreen(
          title: 'Flutter Demo Home Page',
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

/* # Access and Navigation
# when we use blocProvider like this around homeScreen the bloc only can be used inside of HomeScreen and if we navigate to another screen after home screen we can't use instances of bloc
# we have 3 kinds of routing: 1.Anonymous Routing, 2.Named Routing, 3.Generated Routing
# for the Anonymous Routing we can solve the problem like it is explained in home_screen.dart
# */
