

import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:leadsub_flutter_mobileapp/api_services/subPagesService.dart';
import 'package:leadsub_flutter_mobileapp/pages/editSubPage.dart';
import 'package:leadsub_flutter_mobileapp/pages/menu/menu.dart';

import '../api_services/AccountService.dart';
import '../model/SubPage.dart';

class ListSubPages extends StatefulWidget{
  const ListSubPages({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>_ListSubPagesState();
}

class _ListSubPagesState extends State<ListSubPages>{

  final Menu menu=Menu();
  static final SubPagesService _subPagesService=SubPagesService();
  AccountService service=AccountService();
  List<SubPage>subPages=List.empty();

  SubPagesService subPagesService=SubPagesService();

  final Stream<List<SubPage>> _subPagesStream = (() {
    late final StreamController<List<SubPage>> controller;
    controller = StreamController<List<SubPage>>(
      onListen: () async {
        List<SubPage>subPages=await _subPagesService.getSubPages();
        controller.add(subPages);
        await controller.close();
      },
    );
    return controller.stream;
  })();
  StreamBuilder<List<SubPage>> _streamBuilder(){
    return StreamBuilder<List<SubPage>>(
      stream: _subPagesStream,
      builder: (BuildContext context,AsyncSnapshot<List<SubPage>> snapshot){
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
              subPages=snapshot.data!;
              children= _createListSubPages();
              break;
            case ConnectionState.none:
              break;
          }
          return children;
      }
    );
  }
  Widget _createListSubPages(){
      return ListView.builder(
          itemCount: subPages.length,
          itemBuilder: (BuildContext context,int index){
              return _subPageCard(index);

          }
      );
  }
  Widget _subPageCard(int index){

    void _delete(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text('Підтвердіть'),
              content: const Text('Ви хочете видалити дану сторінку?'),
              actions: [
                // The "Yes" button
                TextButton(
                    onPressed: () {
                      subPagesService.deleteSubPages(subPages[index].id);// Close the dialog
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(seconds: 3));
                      Navigator.pushNamedAndRemoveUntil(context, '/listSubPages', (route) => false);
                    },
                    child: const Text('Так')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ні'))
              ],
            );
          });
    }

    void _edit(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text('Підтвердіть'),
              content: const Text('Ви хочете редагувати дану сторінку?'),
              actions: [
                // The "Yes" button
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EditSubPage(subpage: subPages[index])), (route) => false);
                    },
                    child: const Text('Так')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ні'))
              ],
            );
          });
    }

    return Card(
      key: Key(subPages[index].id.toString()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(15),
      color: fromCssColor('#E9E9E9'),
      child:Column(
        children: [
          SizedBox(height: 10),
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child:Text(subPages[index].header!.length >= 24 ? '${subPages[index].header!.substring(0,24)}...' : subPages[index].header!,style: const TextStyle(
                       fontSize: 16,
                       fontFamily: 'Arial',
                       fontWeight: FontWeight.w700
                        ),textScaleFactor: 1.6,)
              )
            ],
          ),
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
                 margin: const EdgeInsets.all(10),
                 height: 80,
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                   color: Colors.white,
                   boxShadow: const [
                     BoxShadow(
                         color: Colors.black26,
                         blurRadius: 1,
                         offset: Offset(1, 1)
                     )
                   ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(height: 30),
                        Text('Views: ${subPages[index].viewsCount}',
                            style: const TextStyle(
                                color:Colors.black,
                                fontSize: 15,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w900
                            )),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        SizedBox(width: 10),
                        SizedBox(height: 30),
                        Text('Subscriptions: ${subPages[index].subscriptionsCount}',
                        style: const TextStyle(
                            color:Colors.green,
                            fontSize: 15,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w900
                        )),
                      ]
                    ),
                  ]
                ))
             ),
             Container(
               margin: const EdgeInsets.all(10),
               height: 80,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 color: Colors.white,
                   boxShadow: const [
                   BoxShadow(
                       color: Colors.black26,
                       blurRadius: 1,
                       offset: Offset(1, 1)
                   )]
               ),
               child: Padding(
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children:[
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(width: 10),
                         SizedBox(height: 30),
                         Text('Subscription Rate: ${subPages[index].subscriptionsCount/100}',
                             style: const TextStyle(
                                 color:Colors.black,
                                 fontSize: 15,
                                 fontFamily: 'Arial',
                                 fontWeight: FontWeight.w900,
                                  overflow: TextOverflow.fade
                             )),
                       ],
                     ),
                     Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children:[
                           SizedBox(width: 10),
                           SizedBox(height: 30),
                           Text('Creation Date: ${subPages[index].creationDateToString()}',
                               style: const TextStyle(
                                   color:Colors.black,
                                   fontSize: 15,
                                   fontFamily: 'Arial',
                                   fontWeight: FontWeight.w900
                               ),
                             overflow: TextOverflow.fade,
                             maxLines: 1,
                             softWrap: false,)
                         ],
                     ),
                   ]
               ),
               )
             )
           ],
         ),

         Row(//CRUD Buttons
           mainAxisAlignment: MainAxisAlignment.center,
            children: [

              IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye_outlined,color: Colors.black),iconSize: 35.0,padding: const EdgeInsets.all(20),),
              IconButton(onPressed: (){ _edit(context); }, icon: const Icon(Icons.edit,color: Colors.black),iconSize: 35.0,padding:const EdgeInsets.all(20)),
              IconButton(onPressed: (){ _delete(context); }, icon: const Icon(Icons.delete_forever, color: Colors.black),iconSize: 35.0,padding:const EdgeInsets.all(20))
            ],
          )

        ],
      )
    );

  }



  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: menu.menuAppBar(),
        drawer: menu.menuDrawer(context),
        body: _streamBuilder(),
      );
  }

}