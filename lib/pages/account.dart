import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/api_services/AccountInfoService.dart';
import 'package:leadsub_flutter_mobileapp/model/User.dart';
import 'package:leadsub_flutter_mobileapp/model/apiRequestModels/registrationModel.dart';
import 'package:leadsub_flutter_mobileapp/pages/widgets/ChangePlanButton.dart';
import 'package:leadsub_flutter_mobileapp/pages/widgets/accountStat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_services/AccountService.dart';
import 'dart:convert';


class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  User user = User(displayName: '', email: '', password: '');

  final Stream<User> accountInfoStream = (() {
    late final StreamController<User> controller;
    controller = StreamController<User>(
      onListen: () async {
        AccountInfoService accountInfoService = AccountInfoService();
        User user =await accountInfoService.getUserData();
        controller.add(user);
        await controller.close();
      },
    );
    return controller.stream;
  })();

  StreamBuilder<User> _streamBuilder(){
    return StreamBuilder<User>(
        stream: accountInfoStream,
        builder: (BuildContext context,AsyncSnapshot<User> snapshot){
          Widget children=const Center(
            child: CircularProgressIndicator(),
          );
          if(snapshot.hasError){
            children= const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            );
          }
          switch(snapshot.connectionState){
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              children= const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 10.0,
                ),

              );
              break;
            case ConnectionState.done:
              user = snapshot.data!;
              children= AccountInfoW();
              break;
            case ConnectionState.none:
              break;
          }
          return children;
        }
    );
  }


  Widget AccountInfoW(){
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 24),
        buildName(),
        const SizedBox(height: 24),
        Center(child: buildUpgradeButton()),
        const SizedBox(height: 48),
        buildAbout(),
      ],
    );
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      body: _streamBuilder()
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        user.displayName!,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email!,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To Business or Ultimate',
    onClicked: () {},
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.password!,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}