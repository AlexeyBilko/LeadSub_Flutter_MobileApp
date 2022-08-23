import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/pages/confirmEmail.dart';
import 'package:leadsub_flutter_mobileapp/pages/register.dart';
import 'package:leadsub_flutter_mobileapp/pages/login.dart';

import 'listSubPages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/login',
        routes: {
          '/listSubPages':(context)=>const ListSubPages(),
          '/login':(context)=>const Login(),
          '/register':(context)=>const Register(),
          '/confirmEmail':(context)=>const ConfirmEmail()
        },
    );
  }
}