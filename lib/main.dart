import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:remote_config_app/src/ui/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  // Documentacion
  // https://firebase.flutter.dev/docs/overview/#initializing-flutterfire
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final error = Container(
      color: Colors.white,
      child: Center(
        child: Text('Error', style: TextStyle(color: Colors.red)),
      ),
    );

    final loading = Container(
        color: Colors.white,
        child: Center(
            child: Text('Loading...', style: TextStyle(color: Colors.blue))));

    return MaterialApp(
        title: 'Remote Config',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _error
            ? error
            : !_initialized
                ? loading
                : HomeScreen());
  }
}
