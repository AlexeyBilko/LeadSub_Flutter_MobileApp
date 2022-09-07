import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:leadsub_flutter_mobileapp/pages/register.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api_services/AccountService.dart';
import '../model/User.dart';
import 'menu/menu.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String errorMessage="";
  AccountService accountService=AccountService();


  Widget _entryEmailField(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _entryPasswordField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          //name textfield
          Container(
            child: TextField(
              controller: passController,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 52, 10, 168),
                Color(0xff3362DB)
              ])),
      child: Column(
        children: [
          TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  minimumSize: Size(MediaQuery.of(context).size.width, 37),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: ()async {
                var res = await accountService.login(emailController.text, passController.text);
                if (res['status'] == 400) {
                  _alertDialogErrorMessage("Невірні дані");
                }
                else if (res['status'] != 200 && res['status'] != 204) {
                  _alertDialogErrorMessage("Невірний логін або пароль");
                }
                else {
                  Navigator.pushNamedAndRemoveUntil(context, '/listSubPages', (route) => false);
                }
              },
              child: const Text('Увійти')),
        ],
      ),
    );
  }
  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Register()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Створити новий акаунт',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
            const Text('Lead',
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                  color: Colors.black
              ),),


            Text('Sub', style:
            TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w900,
                fontSize: 35,
                color: fromCssColor('#3362DB')
            ),),
      ] ,
    );



  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryEmailField("Електронна пошта"),
        _entryPasswordField("Пароль", isPassword: true),
      ],
    );
  }

  void _alertDialogErrorMessage(String message)
  {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Невірний логін або пароль',
          style: TextStyle(color: Colors.red), ),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('ОК'))
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 120),
                      _title(),
                      const SizedBox(height: 50),
                      _emailPasswordWidget(),
                      const SizedBox(height: 0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.centerRight,
                        child:
                            TextButton(
                                style: TextButton.styleFrom(
                                    minimumSize: Size(50, 10),
                                    primary: Colors.black,
                                    textStyle: const TextStyle(fontSize: 14)),
                                onPressed: ()async {
                                    const url = 'http://alexeyleadsub-001-site1.itempurl.com/Account/EnterEmail';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                },
                                child: const Text('Забули пароль?')),
                      ),
                      SizedBox(height: 15),
                      _submitButton(),
                      SizedBox(height: 0),
                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
