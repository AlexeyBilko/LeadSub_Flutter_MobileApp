import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/pages/addSubPage.dart';
import 'package:leadsub_flutter_mobileapp/pages/confirmEmail.dart';
import 'package:leadsub_flutter_mobileapp/pages/editSubPage.dart';
import 'package:leadsub_flutter_mobileapp/pages/register.dart';
import 'package:leadsub_flutter_mobileapp/pages/login.dart';

import 'account.dart';
import 'listSubPages.dart';
import 'newaccount.dart';

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
          '/confirmEmail':(context)=>const ConfirmEmail(),
          '/addSubPage':(context)=>const AddSubPage(),
          '/account':(context)=>Account(),
          '/newaccount':(context)=>NewAccount()

        },
    );
  }
}