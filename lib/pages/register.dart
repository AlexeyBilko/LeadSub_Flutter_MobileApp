import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leadsub_flutter_mobileapp/api_services/AccountService.dart';
import 'package:leadsub_flutter_mobileapp/model/apiRequestModels/registrationModel.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AccountService _accountService=AccountService();
  
  String _emailValidation="";
  String _passwordValidation="";
  String _confirmPasswordValidation="";
  String _userNameValidation="";


  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();


  Widget _entryNameField(String title, {bool isPassword = false}) {
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
              controller: name,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
          Visibility(
            visible: _userNameValidation==""?false:true,
              child: Text(_userNameValidation,
          style:const TextStyle(
          color: Colors.red,
              fontSize: 14,
              fontFamily: 'Roboto'
          ))
          )
        ],
      ),
    );
  }

  Widget _entryEmailField(String title, {bool isPassword = false}) {
    //String errors=
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
              controller: email,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
          Visibility(
            visible: _emailValidation==""?false:true,
            child: Text(
              _emailValidation,
              style:const TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontFamily: 'Roboto'
              )
          ),
          )
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          //name textfield
          Container(
            child: TextField(
              controller: password,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
          Visibility(
              visible: _passwordValidation==""?false:true,
              child: Text(
                  _passwordValidation,
                  style:const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: 'Roboto'
                  )
              ),
          )
        ],
      ),
    );
  }
  Widget _confirmPasswordField(String title, {bool isPassword = false}){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          //name textfield
          Container(
            child: TextField(
              controller: confirmPassword,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
          Visibility(
            visible: _confirmPasswordValidation==""?false:true,
            child: Text(
                _confirmPasswordValidation,
                style:const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontFamily: 'Roboto'
                )
            ),
          )
        ],
      ),
    );
  }



  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
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
              minimumSize: Size(MediaQuery.of(context).size.width, 40)),
            onPressed: ()async{
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
              RegistrationModel model=RegistrationModel(email: email.text, userName: name.text, password:password.text, confirmPassword: confirmPassword.text);
                Map errors= await _accountService.sendVeryficationCode(model);
                if(errors.isEmpty){
                  Navigator.pushNamed(context, '/confirmEmail');
                }
                else{
                  _createValidationStrings(errors);
                  _showModalError(errors);
                }
            },

            child: const Text(
              'Далі',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(children: [
        TextSpan(
          text: 'Створіть свій власний акаунт\n',
          style: TextStyle(
              color: Color(0xff000000), fontSize: 24, fontFamily: 'Arial', fontWeight: FontWeight.bold),

          ),
      ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: Column(
        children: <Widget>[
          _entryNameField("Ім'я"),
          _entryEmailField("Електронна пошта"),
          _entryPasswordField("Пароль", isPassword: true),
          _confirmPasswordField("Підтвердіть пароль", isPassword: true),
        ],
      ),
    );
  }

  void _showModalError(Map errors){
    if(errors["OtherErrors"]!=null) {
      String errorText="";
      for (int i = 0; i < errors["OtherErrors"].length; ++i) {
          errorText+="${i+1}. ${errors["OtherErrors"][i]}\n";
      }

      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text('Повідомлення'),
              content: Text(errorText),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('ОК'))
              ],
            );
          });
    }
  }

  void _createValidationStrings(Map errors){
    if(errors["Email"]!=null) {
      if (errors["Email"].length != 0 && errors["Email"].isNotEmpty) {
        setState(() {
          _emailValidation = "";
          for (int i = 0; i < errors["Email"].length; ++i) {
            _emailValidation += "${errors["Email"][i]}\n";
          }
        });
      }
    }
    else{
      setState((){
        _emailValidation="";
      });
    }


    if(errors["UserName"]!=null) {
      if (errors["UserName"].length != 0 && errors["UserName"].isNotEmpty) {
        setState(() {
          _userNameValidation = "";
          for (int i = 0; i < errors["UserName"].length; ++i) {
            _userNameValidation += "${errors["UserName"][i]}\n";
          }
        });
      }
    }
    else{
      setState((){
        _userNameValidation="";
      });
    }


    if(errors["Password"]!=null) {
      if (errors["Password"].length != 0 && errors["Password"].isNotEmpty) {
        setState(() {
          _passwordValidation = "";
          for (int i = 0; i < errors["Password"].length; ++i) {
            _passwordValidation += "${errors["Password"][i]}\n";
          }
        });
      }
    }
    else{
      setState((){
        _passwordValidation="";
      });
    }





    if(errors["ConfirmPassword"]!=null) {
      if (errors["ConfirmPassword"].length != 0 && errors["ConfirmPassword"].isNotEmpty) {
        setState(() {
          _confirmPasswordValidation = "";
          for (int i = 0; i < errors["ConfirmPassword"].length; ++i) {
            _confirmPasswordValidation += "${errors["ConfirmPassword"][i]}\n";
          }
        });
      }
    }
    else{
      setState((){
        _confirmPasswordValidation="";
      });
    }





  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffffffff),
                  Color(0xffffffff)
                ])),
        child: Column(
          children: [
            const SizedBox(
              height: 44,
            ),
            _title(),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  margin: const EdgeInsets.only(top: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _emailPasswordWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        _submitButton(),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}