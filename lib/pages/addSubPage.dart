


import 'dart:convert';
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

  final String emptyImage="https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-13.png";
  
  String AvatarBase64="";
  String MainImageBase64="";

  late PlatformFile Avatar;
  late PlatformFile MainImage;


  final TextEditingController header=TextEditingController();
  final TextEditingController titleController=TextEditingController();
  final TextEditingController instagramLink=TextEditingController();
  final TextEditingController materialLink=TextEditingController();
  final TextEditingController description=TextEditingController();
  final TextEditingController successDescription=TextEditingController();
  final List<String>_buttonToFollowTextVariants=[
    'Отримати',
    'Відкрити',
    'Отримати це'
  ];
  final List<String>_buttonToGetMaterialTitleVariants=[
    'Отримати',
    'Підписатися',
    'Відкрити',
    'Отримати Це'
  ];

  String _buttonToFollowText="Отримати";
  String _buttonToGetMaterial="Отримати";

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

  Widget CreatePageHeader(String title) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
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
          title: const Text('Без електронної пошти'),
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
          title: const Text('Збирати електронну пошту'),
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
  Widget _dropDownButtonsContainer(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:const [
                Text(
                  "Текст на кнопці \"Отримати\" *    ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                SizedBox(height: 30,),
                Text(
                  "Текст на кнопці успіх *",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              )
            ],
          )
        ],

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
                controller: successDescription,
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
                  minimumSize: Size(MediaQuery.of(context).size.width, 35),
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: ()async {
                  if(instagramLink.text == "" || instagramLink.text == null ||
                    materialLink.text == "" || materialLink.text == null ||
                    titleController.text == "" || titleController.text == null ||
                    header.text == "" || header.text == null ||
                    description.text == "" || description.text == null ||
                    successDescription.text == "" || successDescription.text == null ||
                    AvatarBase64 == "" || MainImageBase64 == "") {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Попередження'),
                            content: const Text('Заповніть всі поля для створення Підписної Сторінки'),
                            actions: [
                              // The "Yes" button
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    },
                                  child: const Text('Зрозуміло'))
                            ],
                          );
                        });
                  }
                  else {
                    subPagesService.createSubPage(
                        SubPage(
                          id: 0,
                          instagramLink: instagramLink.text,
                          materialLink: materialLink.text,
                          title: titleController.text,
                          header: header.text,
                          description: description.text,
                          getButtonTitle: _buttonToGetMaterial,
                          successDescription: successDescription.text,
                          successButtonTitle: _buttonToFollowText,
                          avatar: "data:image/${Avatar
                              .extension};base64, ${AvatarBase64}",
                          mainImage: "data:image/${MainImage
                              .extension};base64, ${MainImageBase64}",
                          subscriptionsCount: 0,
                          CollectEmailStatus: isCollectEmails == true ? 1 : 0,
                          viewsCount: 0,
                          creationDate: DateTime.now(),
                          userId: null,
                        )
                    );
                    Future.delayed(const Duration(seconds: 3));
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/listSubPages', (route) => false);
                  }
              },
              child: const Text('Створити')
            ),
        ],
      ),
    );
  }
  Widget _uploadAvatarPicker(){
      final imageWidget=AvatarBase64==""?const Icon(Icons.image,size: 100,):Image.memory(base64Decode(AvatarBase64));
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        TextButton(onPressed: ()async{
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type:FileType.custom,
          allowedExtensions: ['png', 'jpg', 'jpeg'],
            withData: true
        );

        if (result != null)
        {
          final imageBytes = result.files[0].bytes?.toList();
          setState((){
            Avatar=result.files[0];
            AvatarBase64=base64Encode(imageBytes!);
          });
        }
      }, child: const Text('Завантажити аватар')),
          imageWidget
        ]
      );
  }


  Widget _uploadMainImagePicker(){
    final imageWidget=MainImageBase64==""?const Icon(Icons.image,size: 100,):Image.memory(base64Decode(MainImageBase64));
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          TextButton(onPressed: ()async{
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type:FileType.custom,
              allowedExtensions: ['png', 'jpg', 'jpeg'],
              withData: true
            );

            if (result != null)
            {
              final imageBytes = result.files[0].bytes?.toList();
              setState((){
                MainImage=result.files[0];
                MainImageBase64=base64Encode(imageBytes!);
              });
            }
          }, child: const Text('Завантажити головне зображення')),
          imageWidget
        ]
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
              CreatePageHeader("Створити нову Підписну Сторінку"),
              _entryTitleField("Назва (тільки для вас) *"),
              _entryHeaderField("Заголовок (всі будуть бачити) *"),
              _entryInstagramLinkField("Ваш Нікнейм в Інстаграм *"),
              _entryMaterialLinkField("Посилання на матеріал *"),
              _collectEmails(),
              const SizedBox(
                height: 15,
              ),
              _uploadAvatarPicker(),
              const SizedBox(
                height: 15,
              ),
              _uploadMainImagePicker(),
              const SizedBox(
                height: 15,
              ),
              _entrySuccessDescriptionsField("Повідомлення про успішну перевірку *"),
              const SizedBox(
                height: 15,
              ),
              _dropDownButtonsContainer(),
              const SizedBox(
                height: 15,
              ),
              _entryDescriptionsField("Опис сторінки*"),
              const SizedBox(
                height: 20,
              ),
              _addButton(),
              const SizedBox(
                height: 40,
              ),
            ],
        ),)
      );
  }

}