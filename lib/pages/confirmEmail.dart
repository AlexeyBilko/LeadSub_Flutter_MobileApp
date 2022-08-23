import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadsub_flutter_mobileapp/model/apiRequestModels/registrationModel.dart';

import '../api_services/AccountService.dart';

class ConfirmEmail extends StatefulWidget{
  const ConfirmEmail({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_ConfirmEmailState();

}

class _ConfirmEmailState extends State<ConfirmEmail>{

  final TextEditingController verificationCode = TextEditingController();
  final AccountService _accountService=AccountService();

  Widget _entryVeryficationCodeField(String title, {bool isPassword = false}) {
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
          Container(
            child: TextField(
              controller: verificationCode,
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
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: ()async {
                  Map res= await _accountService.registration(int.parse(verificationCode.text));
                  if(res.isNotEmpty){
                    Navigator.pushNamedAndRemoveUntil(context, '/listSubPages', (route) => false);
                  }
                  else{
                    print("^^^^^^^^^^^^");
                  }
              },
              child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(

        body:Container(
          margin:const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _entryVeryficationCodeField("Введіть код, що прийшов на вашу пошту"),
              _submitButton()
            ],
          )
      )
      );
  }


}
