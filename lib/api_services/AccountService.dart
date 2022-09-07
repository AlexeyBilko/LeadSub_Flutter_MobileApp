import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/api_services/ApiConfiguration/ApiConfiguration.dart';
import 'package:http/http.dart' as http;
import 'package:leadsub_flutter_mobileapp/model/apiRequestModels/changePasswordRequestModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/apiRequestModels/registrationModel.dart';

class AccountService extends ChangeNotifier{

    final String _tokenUrl="/token";
    String? access_token;

    Future<Map>sendVeryficationCode(RegistrationModel apiModel)async
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
          if(httpResponse.statusCode==200)
          {
            final prefs = await SharedPreferences.getInstance();
            prefs.setInt("verificationCode", jsonResponse['veryficationCode']);

            prefs.setString("Email", apiModel.email);
            prefs.setString("UserName", apiModel.userName);
            prefs.setString("Password", apiModel.password);
            prefs.setString("ConfirmPassword", apiModel.confirmPassword);
            return Map();
          }
          if(httpResponse.statusCode==400){
            print(httpResponse.statusCode);
            if(jsonResponse["errors"]!=null){
              print(jsonResponse["errors"]);
              return jsonResponse["errors"];
            }
            else{
              List<String>strErrors=[];
              if(jsonResponse["Password"]!=null){
                for (int i = 0; i < jsonResponse["Password"].length; ++i) {
                  strErrors.add(jsonResponse["Password"][i]);
                }
              }
              if(jsonResponse["Email"]!=null){
                for (int i = 0; i < jsonResponse["Email"].length; ++i) {
                  strErrors.add(jsonResponse["Email"][i]);
                }
              }
              Map errors={
                "OtherErrors":strErrors
              };
              return errors;
            }
          }
        }
        Map dict={"UnknownError":"Помилка серверу"};
        return dict;
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
            final jsonResponse = jsonDecode(httpResponse.body);
            prefs.clear();
            prefs.setString('access_token', jsonResponse['access_token']);
            prefs.setString('userId', jsonResponse['userId']);
            return jsonResponse;
          }
        }
        return {};
    }

    Future<Map<String,dynamic>> login(String email,String password) async
    {
        var url=Uri.http(ApiConfig.baseUrl,ApiConfig.apiPath +ApiConfig.accountControllerPath +ApiConfig.getTokenPath);
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
        if(httpResponse.statusCode==200) {
              final jsonResponse = jsonDecode(httpResponse.body);
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('access_token', jsonResponse['access_token']);
              prefs.setString('userId', jsonResponse['userId']);
              print(prefs.getString('access_token'));
              print(jsonResponse['status']);
              jsonResponse['status'] = httpResponse.statusCode;
              print(jsonResponse['status']);
              return jsonResponse;
        }
        return {};
    }
   void uploadToken()async{
      final prefs =await SharedPreferences.getInstance();
      access_token= prefs.getString('access_token');
    }

   Future<Map<String, dynamic>> logout() async{
     var url=Uri.http(ApiConfig.baseUrl,ApiConfig.apiPath + ApiConfig.accountControllerPath + ApiConfig.logout);
     Map dictionary = {};
     var body=jsonEncode(dictionary);
     var httpResponse= await http.post(
       url,
       body: body,
       headers: {
         "Content-Type": "application/json",
         "accept": "application/json",
         "Access-Control-Allow-Origin": "*"
       },);
       final jsonResponse = jsonDecode(httpResponse.body);
       final prefs = await SharedPreferences.getInstance();
       prefs.remove('access_token');
       return {};
   }

   Future<int>changePassword(ChangePasswordRequestModel model)async
   {
     final prefs = await SharedPreferences.getInstance();
     String? token=prefs.getString('access_token');
     if(token!=null){
       String accountInfoUrl=ApiConfig.apiPath+ApiConfig.accountControllerPath+ApiConfig.changePassword;
       var requestUrl=Uri.http(ApiConfig.baseUrl, accountInfoUrl);
       var body=model.toJson();
       var httpResponse = await http.post(
         requestUrl,
         headers: {
           "Access-Control-Allow-Origin": "*",
           "Authorization": "Bearer $token",
           "Content-type":"application/json"
         },
           body: body);
       return httpResponse.statusCode;
     }
     return 400;
   }
}