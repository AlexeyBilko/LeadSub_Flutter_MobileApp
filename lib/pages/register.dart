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
        ],
      ),
    );
  }

  Widget _entryEmailField(String title, {bool isPassword = false}) {
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
                  hintText: "8 contains with 1 char and 1 digit",
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
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
                  hintText: "8 contains with 1 char and 1 digit",
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
            onPressed: ()async {
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
              RegistrationModel model=RegistrationModel(email: email.text, userName: name.text, password:password.text, confirmPassword: confirmPassword.text);
              bool res=await _accountService.sendVeryficationCode(model);
              if(res) {
                Navigator.pushNamed(context, '/confirmEmail');
              }
            },
            child: const Text(
              'Next',
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
          text: 'Create Your Account\n',
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
          _entryNameField("Name"),
          _entryEmailField("Email"),
          _entryPasswordField("Password", isPassword: true),
          _confirmPasswordField("Confirmed Password", isPassword: true),
        ],
      ),
    );
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