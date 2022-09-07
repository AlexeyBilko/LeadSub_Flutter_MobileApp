
class AccountInfoResponseModel{
    String email;
    String displayName;
    String packageName;
    int price;
    int maxSubPagesCount;
    int maxSubscriptionsCount ;
    int subPagesCount;
    int subscriptionsCount;

    AccountInfoResponseModel({
        required this.email,
        required this.displayName,
        required this.packageName,
        required this.price,
        required this.maxSubPagesCount,
        required this.maxSubscriptionsCount,
        required this.subscriptionsCount,
        required this.subPagesCount
    }){}
    factory AccountInfoResponseModel.empty()=>AccountInfoResponseModel(
        email: "",
        displayName: "",
        packageName: "",
        price: 0,
        maxSubPagesCount: 0,
        maxSubscriptionsCount: 0,
        subscriptionsCount: 0,
        subPagesCount: 0
    );



    factory AccountInfoResponseModel.fromJson(Map<String, dynamic> json)=> AccountInfoResponseModel(
        email: json["email"],
        displayName: json["displayName"],
        packageName: json["packageName"],
        price:json["price"],
        maxSubPagesCount: json["maxSubPagesCount"],
        maxSubscriptionsCount: json["maxSubscriptionsCount"],
        subPagesCount: json["subPagesCount"],
        subscriptionsCount: json["subscriptionsCount"]
    );

}