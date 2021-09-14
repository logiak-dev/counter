import 'dart:async';
import 'package:counter/counter.dart';
import 'package:flutter/material.dart';

Future main() async {
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<DemoApp> {
  GlobalKey<CounterState> key = GlobalKey<CounterState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Counter Demo',
        home: Builder(
            builder: (context) => Scaffold(
                body: Center(
                    child: SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Counter(key),
                            IconButton(
                              icon: Icon(Icons.refresh, color: Colors.white),
                              onPressed: () => print(
                                  key.currentState?.ratePerMinute.toString()),
                            )
                          ],
                        ))))));
  }
}
