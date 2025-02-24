import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    if (value < 99) {
      value += 1;
      notifyListeners();
    }
  }

  void decrement() {
    if (value > 0) {
      value -= 1;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Color getBackgroundColor(int value) {
    if (value <= 12) return Colors.lightBlueAccent;
    if (value <= 19) return Colors.lightGreen;
    if (value <= 30) return Colors.yellow;
    if (value <= 50) return Colors.orange;
    return Colors.grey;
  }

  String getMessage(int value) {
    if (value <= 12) return "You're a child!";
    if (value <= 19) return "Teenager time!";
    if (value <= 30) return "You're a young adult!";
    if (value <= 50) return "You're an adult now!";
    return "Golden years!";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, child) {
        return Scaffold(
          backgroundColor: getBackgroundColor(counter.value),
          appBar: AppBar(title: const Text('Age Counter')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getMessage(counter.value),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Slider(
                  value: counter.value.toDouble(),
                  min: 0,
                  max: 99,
                  divisions: 99,
                  label: counter.value.toString(),
                  onChanged: (double newValue) {
                    counter.value = newValue.toInt();
                    counter.notifyListeners();
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: LinearProgressIndicator(
                    value: counter.value / 99,
                    color: counter.value < 33
                        ? Colors.green
                        : (counter.value < 67 ? Colors.yellow : Colors.red),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: counter.decrement,
                tooltip: 'Decrease Age',
                child: const Text('Decrease Age',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ),
              FloatingActionButton(
                onPressed: counter.increment,
                tooltip: 'Increase Age',
                child: const Text('Increase Age',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        );
      },
    );
  }
}
