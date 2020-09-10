import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_appavailability/flutter_appavailability.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer _timer;
  int _start = 2;

  openApp() async {
    AppAvailability.launchApp("com.zerotier.one").then((_) {
      print("App ZeroTier One launched!");
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("App ZeroTier One not found!")
      ));
      print(err);
    });
  }

  startTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
          if (_start < 1) {
            timer.cancel();
            openApp();
          } 
          else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('arranque de aplicacion'),
        ),
        body: Center(
          child: Text("Abriendo aplicacion, espera unos segundos"),
        ),
      ),
    );
  }
}