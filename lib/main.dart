import 'package:cubit2cubit_listener/cubits/color/color_cubit.dart';
import 'package:cubit2cubit_listener/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'cubit2cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int incrementSize = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ColorCubit, ColorState>(
      listener: (context, state) {
        if (state.color == Colors.red) {
          incrementSize = 1;
        } else if (state.color == Colors.green) {
          incrementSize = 10;
        } else if (state.color == Colors.blue) {
          incrementSize = 100;
        } else if (state.color == Colors.black) {
          context.read<CounterCubit>().changeCounter(-100);
          incrementSize = -100;
        }
      },
      child: Scaffold(
        backgroundColor: context.watch<ColorCubit>().state.color,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text(
                  'Change Color',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  context.read<ColorCubit>().changeColor();
                },
              ),
              const SizedBox(height: 20),
              Text(
                '${context.watch<CounterCubit>().state.counter}',
                style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  'Increment Color',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  context.read<CounterCubit>().changeCounter(incrementSize);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
