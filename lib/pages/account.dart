import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:leadsub_flutter_mobileapp/api_services/AccountInfoService.dart';
import 'package:leadsub_flutter_mobileapp/model/User.dart';
import 'package:leadsub_flutter_mobileapp/model/apiRequestModels/registrationModel.dart';
import 'package:leadsub_flutter_mobileapp/pages/widgets/ChangePlanButton.dart';
import 'package:leadsub_flutter_mobileapp/pages/widgets/accountStat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_services/AccountService.dart';
import 'dart:convert';

import 'menu/menu.dart';


class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  final Menu _menu=Menu();
  User user = User(displayName: '', email: '', password: '');
  TextEditingController passController = TextEditingController();
  
  

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
              children= _accountInfoW();
              break;
            case ConnectionState.none:
              break;
          }
          return children;
        }
    );
  }


  Widget _accountInfoW(){
    return SingleChildScrollView( child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
         children:[
           const SizedBox(height: 10),
           Text('Привіт ${user.displayName}',style: const TextStyle(
             fontSize: 30,
             fontFamily: 'Roboto'
           )),
           Text(user.email,style: const TextStyle(
               fontSize: 24,
               fontFamily: 'Roboto'
           )),
           const SizedBox(height: 30),
           _currentPlan(),
           const SizedBox(height: 20),
           _statisticsCard(),
           const SizedBox(height: 20),
            _changePasswordCard()
           
         ]
        )
      ],
    ));
  }
  Widget _blueButton(String title){
    return TextButton(
        onPressed: (){}, 
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                )
            ),
            minimumSize: MaterialStateProperty.all<Size>(const Size(240,50)),
            backgroundColor:MaterialStateProperty.all<Color>(fromCssColor('#4C59CF'))
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(title,style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Roboto',
            color: Colors.white
        )))
    );
  }

  Widget _currentPlan(){
      return Card(
        color: fromCssColor('#E9E9E9'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
        child: Padding(
          padding: const EdgeInsets.all(10),
            child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Обраний пакет:',style:TextStyle(
              fontSize: 30,
              fontFamily: 'Roboto',
            )),
            SizedBox(height: 10),
            Text('Starter',style:TextStyle(
            fontSize: 26,
            fontFamily: 'Roboto'
            )),
            SizedBox(height: 13),
            Text('Ціна 29\$ місяць',style:TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto'
            )),
            SizedBox(height: 10),
            Text('Максимальна кількість підписників',style:TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto'
            )),
            SizedBox(height: 7),
            Text('Максимальна кількість підписних сторінок',style:TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto'
            )),
            SizedBox(height:15),
            _blueButton('Змінити план')
          ],
          
        ),
        ])));
  }
  Widget _statisticsCard(){
    return SizedBox(
      width: 330,
      child:Card(
        color: fromCssColor('#E9E9E9'),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
         ),
      child: Padding(
        padding:const EdgeInsets.all(10),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Загальна статистика:',style:TextStyle(
                  fontSize: 23,
                  fontFamily: 'Roboto',
                )),


              ],
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Text('Всього підписників:',style:TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto'
                )),

              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Text('Всього переглядів',style:TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto'
                ))
              ],
            )
          ],
        ),
      ),
    ));
  }
  Widget _changePasswordCard(){
    return SizedBox(
        width: 330,
        child:Card(
          color: fromCssColor('#E9E9E9'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          child: Padding(
            padding:const EdgeInsets.all(13),
            child:Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 10,),
                    Text('Введіть пароль:',style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    )),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300.0,
                  height: 40,
                  child: TextField(
                      controller: passController,
                      obscureText: true,
                      decoration:InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )
                          ),
                          fillColor: fromCssColor('#D0D0D0'),
                          filled: true),
                      style: const TextStyle(fontSize: 18.0,color:Colors.black)
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 10,),
                    Text('Новий пароль:',style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    )),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300.0,
                  height: 40,
                  child: TextField(
                      controller: passController,
                      obscureText: true,
                      decoration:InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )
                          ),
                          fillColor: fromCssColor('#D0D0D0'),
                          filled: true),
                      style: const TextStyle(fontSize: 18.0,color:Colors.black)
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 10,),
                    Text('Підтвердити пароль:',style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    )),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300.0,
                  height: 40,
                  child: TextField(
                      controller: passController,
                      obscureText: true,
                      decoration:InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )
                          ),
                          fillColor: fromCssColor('#D0D0D0'),
                          filled: true),
                      style: const TextStyle(fontSize: 18.0,color:Colors.black)
                  ),
                ),
                SizedBox(height: 18),
                _blueButton('Змінити пароль')
              ],
            ),
          ),
        ));
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
        appBar: _menu.menuAppBar(),
        drawer: _menu.menuDrawer(context),
        body: _streamBuilder()
    );
  }
  
}