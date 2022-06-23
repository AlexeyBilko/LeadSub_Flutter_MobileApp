import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/register.dart';
import 'package:leadsub_flutter_mobileapp/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}