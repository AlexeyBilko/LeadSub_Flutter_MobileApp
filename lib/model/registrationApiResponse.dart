class RegistrationApiResponse {
  RegistrationApiResponse({
    required this.name,
    required this.email,
    required this.password,
    required this.userData,
  });

  String name;
  String email;
  String password;
  UserData? userData;

  factory RegistrationApiResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationApiResponse(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        userData: json["UserData"] == null
            ? null
            : UserData.fromJson(json["UserData"] as Map<String, dynamic>),
      );
}

class UserData {
  UserData({
    required this.name,
    required this.email,
    required this.password,
  });

  String name;
  String email;
  String password;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    name: json["name"],
    email: json["email"],
    password: json["password"],
  );
}