//import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  int _people = 0;
  List<Color> _bgColors = [
    Colors.white,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.tealAccent,
    Colors.lightGreenAccent,
    Colors.lightBlueAccent,
  ];
  int _bgColorsIndex = 0;

  void _incrementPeople() {
    // If there are as many people as the counter (limit), show diaog
    if (_people == _counter) {
      _showAlert();
      return;
    }

    // Otherwise, s
    setState(() {
      _people++;
      if (_people == _counter) {
        _showAlert();
      }
    });
  }

  void _decrementPeople() {
    if (_people == 0) return;
    setState(() {
      _people--;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_people > _counter - 1) return;
    setState(() {
      _counter--;
    });
  }

  void _showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Número máximo atingido'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'))
            ],
            content: const Text('O número máximo de pessoas foi atingido!'),
          );
        });
  }

  void _showConfig() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Número permitido de pessoas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$_counter',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _incrementCounter();
                            });
                          },
                          icon: const Icon(Icons.add, color: Colors.green),
                          iconSize: 32,
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _decrementCounter();
                            });
                          },
                          icon: const Icon(Icons.remove, color: Colors.red),
                          iconSize: 32,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Fechar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _pickColor() {
    setState(() {
      _bgColorsIndex =
          _bgColorsIndex == _bgColors.length - 1 ? 0 : _bgColorsIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contador de pessoas'), actions: [
          IconButton(onPressed: _pickColor, icon: const Icon(Icons.brush)),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: _showConfig,
          child: const Icon(Icons.settings),
        ),
        backgroundColor: _bgColors[_bgColorsIndex],
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Text('Há $_people ${_people == 1 ? 'pessoa' : 'pessoas'}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _incrementPeople,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      fixedSize: const Size(100, 60)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    semanticLabel: 'Adicionar',
                  ),
                ),
                ElevatedButton(
                  onPressed: _decrementPeople,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      fixedSize: const Size(100, 60)),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    semanticLabel: 'Remover',
                  ),
                )
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ));
  }
}