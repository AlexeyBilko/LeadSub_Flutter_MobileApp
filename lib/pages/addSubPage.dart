


import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:leadsub_flutter_mobileapp/api_services/subPagesService.dart';
import 'package:leadsub_flutter_mobileapp/model/SubPage.dart';

import 'menu/menu.dart';

class AddSubPage extends StatefulWidget{
  const AddSubPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>_AddSubPageStat();
}

class _AddSubPageStat extends State<AddSubPage>{

  SubPagesService subPagesService=SubPagesService();

  final TextEditingController header=TextEditingController();
  final TextEditingController titleController=TextEditingController();
  final TextEditingController instagramLink=TextEditingController();
  final TextEditingController materialLink=TextEditingController();
  final TextEditingController description=TextEditingController();
  final TextEditingController successDescription=TextEditingController();
  final List<String>_buttonToFollowTextVariants=[
    'Get',
    'Get material',
    'Subscribe',
    'Subscribe to get',
    'Follow',
    'Follow to Get'
  ];
  final List<String>_buttonToGetMaterialTitleVariants=[
    'Already Followed',
    'I\'ve followed',
    'Get',
    'Get my material',
    'Receive material'
  ];

  String _buttonToFollowText="Get";
  String _buttonToGetMaterial="Get";

  bool isCollectEmails=false;
  final Menu menu=Menu();

  Widget _entryHeaderField(String title) {
    return Container(
      margin: const EdgeInsets.all(20),
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
              controller: header,
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

  Widget _entryTitleField(String title) {
    return Container(
      margin: const EdgeInsets.all(20),
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
              controller: titleController,
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

  Widget _entryInstagramLinkField(String title) {
    return Container(
      margin: const EdgeInsets.all(20),
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
              controller: instagramLink,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            )
          )
        ],
      ),
    );
  }


  Widget _entryMaterialLinkField(String title) {
    return Container(
      margin: const EdgeInsets.all(20),
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
                controller: materialLink,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              )
          ),
        ],
      ),
    );
  }

  Widget _collectEmails(){
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Do not require email'),
          leading: Radio<bool>(
            value: false,
            activeColor: fromCssColor('#3362DB'),
            groupValue: isCollectEmails,
            onChanged: (bool? value) {
              setState(() {
                isCollectEmails = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Require email'),
          leading: Radio<bool>(
            value: true,
            activeColor: fromCssColor('#3362DB'),
            groupValue: isCollectEmails,
            onChanged: (bool? value) {
              setState(() {
                isCollectEmails = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _dropDownButtonToFollowTitle()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:[
        const Text(
          "Button to follow title:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        DropdownButton<String>(
      value: _buttonToFollowText,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: fromCssColor('#3362DB'),
      ),
      onChanged: (String? newValue) {
        setState(() {
          _buttonToFollowText = newValue!;
        });
      },
      items: _buttonToFollowTextVariants
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      )]
    );
  }

  Widget _dropDownButtonToGetMaterialTitle()
  {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
          children:const [Text(
            "Button to get material:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),]
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:[
            DropdownButton<String>(
            value: _buttonToGetMaterial,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: fromCssColor('#3362DB'),
            ),
            onChanged: (String? newValue) {
              setState(() {
                _buttonToGetMaterial= newValue!;
              });
            },
            items:_buttonToGetMaterialTitleVariants
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )]
          )]
    );
  }




  Widget _entryDescriptionsField(String title){
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              )
          ),
        ],
      ),
    );
  }

  Widget _entrySuccessDescriptionsField(String title){
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              )
          ),
        ],
      ),
    );
  }

  Widget _addButton(){
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
                  subPagesService.createSubPage(
                    SubPage(
                        id:null,
                        instagramLink: instagramLink.text,
                        materialLink: materialLink.text,
                        title: titleController.text,
                        header: header.text,
                        description: description.text,
                        getButtonTitle: _buttonToGetMaterial,
                        successDescription: successDescription.text,
                        successButtonTitle: _buttonToFollowText,
                        subscriptionsCount: 0,
                        viewsCount: 0,
                        creationDate: DateTime.now(),
                        userId: null,
                        )
                  );
                  Navigator.pushNamedAndRemoveUntil(context, '/listSubPages', (route) => false);
              },
              child: const Text('Create')
            ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: menu.menuAppBar(),
        drawer: menu.menuDrawer(context),
        body:
        SingleChildScrollView(
          child:Column(
            children: [
              _entryTitleField("Title"),
              _entryHeaderField("Header"),
              _entryInstagramLinkField("Instagram link"),
              _entryMaterialLinkField("Material link"),
              _collectEmails(),
              _dropDownButtonToFollowTitle(),
              _dropDownButtonToGetMaterialTitle(),


              _entryDescriptionsField("Description"),
              _addButton(),
            ],
        ),)
      );
  }

}