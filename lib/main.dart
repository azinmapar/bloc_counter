import 'package:bloc_counter/presentation/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final CounterCubit _counterCubit = CounterCubit();

  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    // # wrap with blocProvider<CounterCubit> that returns CounterCubit
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // routes: const {
      // # we don't do it like this
      // '/': (context) => BlocProvider(
      //       create: (BuildContext context) => _counterCubit,
      //       child: const HomeScreen(
      //         title: 'Flutter Demo Home Page',
      //         color: Colors.blueAccent,
      //       ),
      //     ),
      // # Named Routing
      // '/': (context) => BlocProvider.value(
      //       value: _counterCubit,
      //       child: const HomeScreen(
      //         title: 'Flutter Demo Home Page',
      //         color: Colors.blueAccent,
      //       ),
      //     ),
      // '/second': (context) => BlocProvider.value(
      //       value: _counterCubit,
      //       child: const SecondScreen(
      //         title: 'Flutter Demo Second Page',
      //         color: Colors.redAccent,
      //       ),
      //     ),
      // '/third': (context) => BlocProvider.value(
      //       value: _counterCubit,
      //       child: const ThirdScreen(
      //         title: 'Flutter Demo Third Page',
      //         color: Colors.greenAccent,
      //       ),
      //     ),
      // },
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    // # we should do this manually for Named Routing
    // _counterCubit.close();
    _appRouter.dispose();
    super.dispose();
  }
}

/* # Access and Navigation
# when we use blocProvider like this around homeScreen the bloc only can be used inside of HomeScreen and if we navigate to another screen after home screen we can't use instances of bloc
# we have 3 kinds of routing: 1.Anonymous Routing, 2.Named Routing, 3.Generated Routing
# 1. for the Anonymous Routing we can solve the problem like it is explained in home_screen.dart
# 2. for Named Routing in routes we wrap every screen in blocProvider but we don't give them CounterCubit() because then we would have a new instance of cubit for every one of them
# Instead we create a private instance of CounterCubit at the top and use the same one for all of them
# BUT THIS IS NOT A GOOD WAY
# insteadof blocProvider we should use BlocProvider.value
# 3. for Generated Routing first we create a file named app_router.dart, more info inside that file
# */
