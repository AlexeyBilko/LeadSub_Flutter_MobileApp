import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/api_services/AccountInfoService.dart';
import 'package:leadsub_flutter_mobileapp/model/User.dart';
import 'package:leadsub_flutter_mobileapp/model/apiRequestModels/registrationModel.dart';
import 'package:leadsub_flutter_mobileapp/pages/account.dart';
import 'package:leadsub_flutter_mobileapp/pages/widgets/AccountWidget.dart';
import 'package:leadsub_flutter_mobileapp/pages/widgets/ChangePlanButton.dart';
import 'package:leadsub_flutter_mobileapp/pages/widgets/accountStat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_services/AccountService.dart';
import 'dart:convert';


class NewAccount extends StatefulWidget {
  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  @override
  Widget build(BuildContext context) {
      return Container();
  }

}