import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leadsub_flutter_mobileapp/model/RegistrationApiResponse.dart';
import 'package:leadsub_flutter_mobileapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _name;
  static var nm;
  static var _email;
  static var _password;
  SharedPreferences? prefs;

  register(
    String name, email, password, countryCode, context) async {
    prefs = await SharedPreferences.getInstance();
    Map data1 = {
      'email': email,
      'password': password
    };
    print(data1);
    _name = name;

    String body = json.encode(data1);
    var url = Uri.parse('http://localhost:7098/api/account/token');
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );

    prefs!.setString('name', name);
    prefs!.setString('email', email);
    prefs!.setString('password', password);

    nm = prefs!.getString('name');
    _email = prefs!.getString('email');
    _password = prefs!.getString('password');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('success');
    } else {
      print('error');
    }
  }
}