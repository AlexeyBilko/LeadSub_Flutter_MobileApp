import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:leadsub_flutter_mobileapp/api_services/AccountInfoService.dart';
import 'package:leadsub_flutter_mobileapp/model/apiRequestModels/changePasswordRequestModel.dart';
import 'package:leadsub_flutter_mobileapp/model/apiResponseModels/accountInfoResponseModel.dart';
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
  final AccountService _accountService=AccountService();

  late AccountInfoResponseModel model;

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController confirmNewPassword=TextEditingController();
  
  

  final Stream<AccountInfoResponseModel> accountInfoStream = (() {
    late final StreamController<AccountInfoResponseModel> controller;
    controller = StreamController<AccountInfoResponseModel>(
      onListen: () async {
        AccountInfoService accountInfoService = AccountInfoService();
        AccountInfoResponseModel model =await accountInfoService.getAccountInfo();
        controller.add(model);
        await controller.close();
      },
    );
    return controller.stream;
  })();

  StreamBuilder<AccountInfoResponseModel> _streamBuilder(){
    return StreamBuilder<AccountInfoResponseModel>(
        stream: accountInfoStream,
        builder: (BuildContext context,AsyncSnapshot<AccountInfoResponseModel> snapshot){
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
              model = snapshot.data!;
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
           Text('Привіт ${model.displayName}',style: const TextStyle(
             fontSize: 30,
             fontFamily: 'Roboto'
           )),
           Text(model.email,style: const TextStyle(
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
  Widget _blueButton(String title,Function onPress){
    return TextButton(
        onPressed:(){onPress();},
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
            Text(model.packageName,style:TextStyle(
            fontSize: 26,
            fontFamily: 'Roboto'
            )),
            SizedBox(height: 13),
            Text('Ціна ${model.price}\$ місяць',style:TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto'
            )),
            SizedBox(height: 10),
            Text('Максимальна кількість підписників: ${model.maxSubscriptionsCount}',style:TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto'
            )),
            SizedBox(height: 7),
            Text('Максимальна кількість підписних сторінок: ${model.maxSubPagesCount}',style:TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto'
            )),
            SizedBox(height:15),
            _blueButton('Змінити план',(){})
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
              children: [
                SizedBox(width: 15),
                Text('Всього підписників: ${model.subscriptionsCount}',style:TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto'
                )),

              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Text('Всього підписних сторінок: ${model.subPagesCount}',style:TextStyle(
                    fontSize: 15,
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
                      controller: oldPassController,
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
                      controller: newPassword,
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
                      controller: confirmNewPassword,
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
                _blueButton('Змінити пароль',()async{
                    final model=ChangePasswordRequestModel(
                        confirmNewPassword: confirmNewPassword.text,
                        newPassword: newPassword.text,
                        confirmationOldPassword: oldPassController.text
                    );
                    int statusCode=await _accountService.changePassword(model);
                    if(statusCode==200){
                        _showSuccess();
                    }
                    else{
                        _showPasswordValidation();
                    }
                })
              ],
            ),
          ),
        ));
  }
  void _showSuccess(){
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Повідомлення'),
            content: const Text('Пароль успішно змінено!'),
            actions:[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(context,'/account', (route) => false);
                  },
                  child: const Text('ОК'))
            ],
          );
        });
  }
  void _showPasswordValidation(){
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Icon(Icons.error,color: Colors.red,size: 50),
            content: const Text('Невдалося змінити пароль!\n\n'
                '1.Перевірте правильність старого паролю\n'
                '2.Нові паролі мають співпадати\n'
                '3.Перевірте наступні пункти:\n\n'
                '-пароль має бути  не меньше 9 символів\n'
                '-пароль має містити в собі цифри\n'
                '-має бути наявна одна маленька літера\n'
                '-має бути наявна одна велика літера\n'),
            actions:[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('ОК'))
            ],
          );
        });
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