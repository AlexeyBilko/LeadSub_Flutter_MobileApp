import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/model/SubPage.dart';
import 'package:leadsub_flutter_mobileapp/pages/listSubPages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ApiConfiguration/ApiConfiguration.dart';

class SubPagesService extends ChangeNotifier{


  Future<List<SubPage>> getSubPages(String userId)async{

    final prefs = await SharedPreferences.getInstance();
    String? token=prefs.getString('access_token');
    if(token!=null) {
      String subPagesPath = "${ApiConfig.apiPath}${ApiConfig
          .subPagesPath}/$userId";
      var url = Uri.http(ApiConfig.baseUrl, subPagesPath);
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