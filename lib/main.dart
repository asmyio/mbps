import 'package:flutter/material.dart';
import 'package:mbps/pages/dashboard.dart';
// ignore: unused_import
import 'package:mbps/pages/menu.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // initiate Firebase liddis
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // that's all
  runApp(
    LeApp(),
  );
}

class LeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      home: DashboardPage(),
    );
  }
}
