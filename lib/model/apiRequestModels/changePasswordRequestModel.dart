import 'dart:convert';

class ChangePasswordRequestModel{
    String confirmationOldPassword;
    String newPassword;
    String confirmNewPassword;

    ChangePasswordRequestModel({
        required this.confirmNewPassword,
        required this.newPassword,
        required this.confirmationOldPassword
    }){}

     String toJson(){
          Map dictionary={
            "confirmationOldPassword":confirmationOldPassword,
            "newPassword":newPassword,
            "confirmNewPassword":confirmNewPassword
          };
          return jsonEncode(dictionary);
     }
}