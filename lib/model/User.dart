class User {
  String displayName;
  String email;
  String password;

  User({
    required this.displayName,
    required this.email,
    required this.password,
    });

  factory User.fromJson(Map<String, dynamic> json) => User(
    displayName: json["displayName"],
    email: json["email"],
    password: json["password"],
  );
}