import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_path_provider/servise/init_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.storage});

  final IntStorage storage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  int savedValue = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        savedValue = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      count++;
      savedValue++;
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(savedValue);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Path Provider',
          style:
              TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                count = 0;
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
              ))
        ],
      ),
      body: Center(
        child: ListView(reverse: true, children: [
          for (int index = 0; index < 9; index++)
            Builder(builder: (context) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: index * width / 8 * 0.8,
                    child: Text(
                      index == 8
                          ? "          Subhanalloh"
                          : index == 7
                              ? "           J:$savedValue"
                              : index == 6
                                  ? "           $count"
                                  : "",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: width / 6,
                    width: width / 6,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.primaries[(index - count) % 2 + 2],
                        borderRadius: BorderRadius.circular(50)),
                  )
                ],
              );
            })
        ]),
      ),
      floatingActionButton: GestureDetector(
        onTap: _incrementCounter,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(25),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: Colors.purple.withOpacity(0.5)),
        ),
      ),
    );
  }
}
