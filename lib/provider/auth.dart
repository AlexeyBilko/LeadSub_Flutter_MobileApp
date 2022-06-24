import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leadsub_flutter_mobileapp/model/RegistrationApiResponse.dart';
import 'package:leadsub_flutter_mobileapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static var _name;
  static var _email;
  static var _password;
  SharedPreferences? prefs;
  static var token;

  Future<bool> getToken(String email, password) async{
    Map data = {
      'email': email,
      'password': password
    };
    String body = json.encode(data);
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
    if (response.statusCode == 200 || response.statusCode == 201) {
      var res = json.decode(response.body);
      Map responseData = {
        'accessToken': res.access_token,
        'userEmail': res.userName
      };
      print(responseData);
      print('success');
      return true;
    } else {
      print('error');
      return false;
    }
  }

  Future<bool> register(String name, email, password, context) async {
    prefs = await SharedPreferences.getInstance();

    prefs!.setString('name', name);
    prefs!.setString('email', email);
    prefs!.setString('password', password);

    _name = prefs!.getString('name');
    _email = prefs!.getString('email');
    _password = prefs!.getString('password');

    var url = Uri.parse('http://localhost:7098/api/account/register');
    Map dataToSend = {
      'name': _name,
      'email': _email,
      'password': _password
    };

    String body = json.encode(dataToSend);

    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var res = json.decode(response.body);
      print(res);
      getToken(res.email, res.password);
      print('success');
      return true;
    } else {
      print('error');
      return false;
    }
  }
}