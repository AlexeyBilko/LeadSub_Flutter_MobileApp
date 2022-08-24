import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class Menu {

  Widget _menuLogo(){
    return Row(
        children:[
          Column(
            children: const [
              Text('Lead',
                style: TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black
                ),),
            ],
          ),
          Column(
            children: [
             Text('Sub', style:
             TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: fromCssColor('#3362DB')
                    ),),

            ],
          ),
        ] ,
    );
  }
  PreferredSizeWidget menuAppBar(){
      return PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child:AppBar(
        title:_menuLogo(),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      );
  }
  Widget menuDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: _menuLogo(),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Icons.account_box_rounded,size: 30.0,color: fromCssColor('#3362DB')),
            title: const Text('Акаунт',
              style:TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Colors.black
              )),
            selectedTileColor: fromCssColor('#3362DB'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/account', (route) => true);
            },
          ),

          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Icons.supervisor_account,size: 30.0,color: fromCssColor('#3362DB')),
            title: const Text('Мої підписники',
                style:TextStyle(
                fontFamily: 'Arial', fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black)
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Icons.add_box,size: 30.0,color: fromCssColor('#3362DB')),
            title: const Text('Створити сторінку',
                style:TextStyle(
                    fontFamily: 'Arial', fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black)
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Icons.note_alt_rounded,size: 30.0,color: fromCssColor('#3362DB')),
            title: const Text('Мої сторінки',
                style:TextStyle(
                    fontFamily: 'Arial', fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black)
            ),
            onTap: () {
              Navigator.pop(context);
              //Navigator.p
              Navigator.pushNamedAndRemoveUntil(context, '/listSubPages', (route) => true);
            },
            style: ListTileStyle.drawer,
          ),
          ListTile(
           contentPadding: EdgeInsets.all(10),
            leading: const Icon(Icons.exit_to_app_rounded,size: 30.0,color: Colors.red),
            title: const Text('Вийти з акаунту',
                style:TextStyle(
                    fontFamily: 'Arial', fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black)
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => true);
            },
            style: ListTileStyle.drawer,
          )
        ],
      ),
    );
  }
}