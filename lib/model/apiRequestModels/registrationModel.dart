class RegistrationModel{
    String email;
    String userName;
    String password;
    String confirmPassword;

    RegistrationModel({
        required this.email,
        required this.userName,
        required this.password,
        required this.confirmPassword
    });

    factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
        email: json["email"],
        password: json["password"],
        userName: json["userName"],
        confirmPassword: json["confirmPassword"]
    );

}