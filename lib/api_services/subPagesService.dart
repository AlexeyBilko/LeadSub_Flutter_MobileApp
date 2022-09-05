import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/model/SubPage.dart';
import 'package:leadsub_flutter_mobileapp/pages/listSubPages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ApiConfiguration/ApiConfiguration.dart';

class SubPagesService extends ChangeNotifier{

  Future<SubPage>createSubPage(SubPage subPage)async
  {
    final prefs = await SharedPreferences.getInstance();
    String? token=prefs.getString('access_token');
    String userId="";
    if(token!=null) {
      String subPagesPath = "${ApiConfig.apiPath}${ApiConfig
          .subPagesPath}/Add";
      var url = Uri.http(ApiConfig.baseUrl, subPagesPath);
      var body=subPage.toJson();
      var httpResponse = await http.post(
        url,
        headers: {
          "Content-Type":"application/json",
          "Access-Control-Allow-Origin": "*",
          "Authorization": "Bearer $token"
        },
        body: body);
      if(httpResponse.statusCode==200)
      {
          final jsonResponse=jsonDecode(httpResponse.body);
          subPage.id=jsonResponse['id'];
      }
      }
    return subPage;
  }


  Future<List<SubPage>> getSubPages()async{

    final prefs = await SharedPreferences.getInstance();
    String? token=prefs.getString('access_token');
    if(token!=null) {
      String subPagesPath = "${ApiConfig.apiPath}${ApiConfig.subPagesPath}";
      var url = Uri.http(ApiConfig.baseUrl, ApiConfig.apiPath + ApiConfig.subPagesPath);
      var httpResponse = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Authorization": "Bearer $token"
        },);
      if(httpResponse.statusCode==200) {
        List<dynamic> parsedListJson = jsonDecode(httpResponse.body);
        List<SubPage>subPages=List<SubPage>.from(parsedListJson.map((i)=>SubPage.fromJson(i)));
        return subPages;
     }
    }
    return List.empty();
  }

}