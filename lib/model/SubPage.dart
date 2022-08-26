import 'dart:convert';

class SubPage {
  int?id;
  String? instagramLink;
  String? materialLink;
  String? title;
  String? avatar;
  String? header;
  String? description;
  String? getButtonTitle;
  String? mainImage;
  String? successDescription;
  String? successButtonTitle;
  int subscriptionsCount=0;
  int viewsCount=0;
  DateTime? creationDate;
  String?userId;

  SubPage({
    required this.id,
    required this.instagramLink,
    required this.materialLink,
    required this.title,
    this.avatar,
    required this.header,
    required this.description,
    required this.getButtonTitle,
    this.mainImage,
    required this.successDescription,
    required this.successButtonTitle,
    required this.subscriptionsCount,
    required this.viewsCount,
    required this.creationDate,
    required this.userId
  });


  factory SubPage.fromJson(Map<String, dynamic> json) => SubPage(
      id: json["id"],
      instagramLink: json["instagramLink"],
      materialLink:json["materialLink"],
      title:json["title"],
      avatar:json["avatar"],
      header:json["header"],
      description:json["description"],
      getButtonTitle:json["getButtonTitle"],
      mainImage:json["mainImage"],
      successDescription:json["successDescription"],
      successButtonTitle:json["successButtonTitle"],
      subscriptionsCount:json["subscriptionsCount"],
      viewsCount:json["viewsCount"],
      creationDate:DateTime.parse(json["creationDate"]),
      userId:json["userId"]
  );
  String toJson(){
    Map map={
      "id":id,
      "instagramLink":instagramLink,
      "materialLink":materialLink,
      "title":title,
      "avatar":avatar,
      "header":header,
      "description":description,
      "getButtonTitle":getButtonTitle,

      "mainImage":mainImage,
      "successDescription":successDescription,
      "successButtonTitle":successButtonTitle,

      "subscriptionsCount":subscriptionsCount,
      "viewsCount":viewsCount,
      "creationDate":creationDate,

      "userId":userId
    };
    return jsonEncode(map);
  }

  String creationDateToString(){
    return '${creationDate!.day}.${creationDate!.month}.${creationDate!.year}';
  }
}