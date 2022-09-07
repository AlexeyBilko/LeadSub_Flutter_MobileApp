import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/model/SubPage.dart';
import 'package:leadsub_flutter_mobileapp/pages/listSubPages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/User.dart';
import '../model/apiResponseModels/accountInfoResponseModel.dart';
import 'ApiConfiguration/ApiConfiguration.dart';

class AccountInfoService extends ChangeNotifier{
    Future<User> getUserData() async{
      final prefs = await SharedPreferences.getInstance();
      String? token=prefs.getString('access_token');
      if(token!=null) {
        var url=Uri.http(ApiConfig.baseUrl, ApiConfig.apiPath+ApiConfig.accountControllerPath +'/GetUserData');
        var httpResponse = await http.get(
          url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Authorization": "Bearer $token"
          },);
        if(httpResponse.statusCode == 200) {
          User user = User.fromJson(jsonDecode(httpResponse.body));
          return user;
        }
        else return Future.error("status not 200 - ${httpResponse.statusCode}, token: ${token}");
      }
      return Future.error("wrong token");
    }

    Future<AccountInfoResponseModel> getAccountInfo()async {
      final prefs = await SharedPreferences.getInstance();
      String? token=prefs.getString('access_token');
      if(token!=null){
          String accountInfoUrl=ApiConfig.apiPath+ApiConfig.accountControllerPath+ApiConfig.accountInfo;
          var requestUrl=Uri.http(ApiConfig.baseUrl, accountInfoUrl);
          var httpResponse = await http.get(
            requestUrl,
            headers: {
              "Access-Control-Allow-Origin": "*",
              "Authorization": "Bearer $token"
            },);
          if(httpResponse.statusCode==200){
            AccountInfoResponseModel model=AccountInfoResponseModel.fromJson(jsonDecode(httpResponse.body));
            return model;
          }
      }
      return AccountInfoResponseModel.empty();
    }

}