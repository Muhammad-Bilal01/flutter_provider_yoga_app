import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider Yoga App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _counter++;
    });

    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return StreamProvider<MyModel>(
      initialData: MyModel(message: 0),
      create: (BuildContext context) => getModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Consumer<MyModel>(
                builder: (context, myModel, child) {
                  print("rebuild text");

                  return Text(myModel.message.toString());
                },
              ),
              Consumer<MyModel>(
                builder: (context, myModel, child) {
                  print("rebuild Button");
                  return ElevatedButton(
                      onPressed: () {
                        myModel.doSomething();
                      },
                      child: Text("Do Something"));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Stream<MyModel> getModel() {
    return Stream<MyModel>.periodic(
            const Duration(seconds: 2), (x) => MyModel(message: x))
        .take(10); // count between 0 to 10
  }
}

class MyModel {
  int message = 0;

  MyModel({required this.message});

  void doSomething() {
    message = message + 1;
//  notifyListeners();
  }
}
