import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/api_services/ApiConfiguration/ApiConfiguration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/apiRequestModels/registrationModel.dart';

class AccountService extends ChangeNotifier{

    final String _tokenUrl="/token";
    String? access_token;

    Future<bool>sendVeryficationCode(RegistrationModel apiModel)async
    {
        var url=Uri.http(ApiConfig.baseUrl, ApiConfig.apiPath+ApiConfig.accountControllerPath+ApiConfig.confirmEmailPath);
        Map dictionary={
          "Email":apiModel.email,
          "Password":apiModel.password,
          "ConfirmPassword":apiModel.confirmPassword,
          "UserName":apiModel.userName
        };
        var body=jsonEncode(dictionary);
        var httpResponse=await http.post(
          url,
          body: body,
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          }
        );
        if(httpResponse.body.isNotEmpty)
        {
          final jsonResponse = jsonDecode(httpResponse.body);
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt("verificationCode", jsonResponse['veryficationCode']);

          prefs.setString("Email", apiModel.email);
          prefs.setString("UserName", apiModel.userName);
          prefs.setString("Password", apiModel.password);
          prefs.setString("ConfirmPassword", apiModel.confirmPassword);
          return true;
        }
        return false;
    }
    Future<Map<String,dynamic>>registration(int verificationCode)async
    {
        var url=Uri.http(ApiConfig.baseUrl,ApiConfig.apiPath+ApiConfig.accountControllerPath +ApiConfig.registrationPath);
        final prefs = await SharedPreferences.getInstance();
        Map dictionary={
          "Email":prefs.getString('Email'),
          "Password":prefs.getString('Password'),
          "ConfirmPassword":prefs.getString('ConfirmPassword'),
          "UserName":prefs.getString('UserName')
        };
        if(verificationCode==prefs.getInt('verificationCode')) {
          var body = jsonEncode(dictionary);
          var httpResponse = await http.post(
            url,
            body: body,
            headers: {
              "Content-Type": "application/json",
              "accept": "application/json",
              "Access-Control-Allow-Origin": "*"
            },);
          if (httpResponse.statusCode == 200) {
            String email=prefs.getString('Email')!;
            String password=prefs.getString('Password')!;
            prefs.clear();
            return await login(email,password);
          }
        }
        return {};
    }


    Future<Map<String,dynamic>> login(String email,String password) async
    {
        var url=Uri.http(ApiConfig.baseUrl,ApiConfig.apiPath+ApiConfig.accountControllerPath +_tokenUrl);
        Map dictionary = {
          'Email':email,
          'Password':password
        };
        var body=jsonEncode(dictionary);
        var httpResponse=await http.post(
          url,
          body: body,
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },);
        if(httpResponse.body.isNotEmpty) {
          final jsonResponse = jsonDecode(httpResponse.body);
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('access_token', jsonResponse['access_token']);
              print(prefs.getString('access_token'));

          return jsonResponse;
        }
        return {};
    }
   void uploadToken()async{
      final prefs =await SharedPreferences.getInstance();
      access_token= prefs.getString('access_token');
    }

}