import 'package:expense_app_ui/data/local/db_helper.dart';

class UserModel {
  int? id;
  String username;
  String email;
  String mobile;
  String password;
  String createAt;

  UserModel(
      {this.id,
        required this.username,
        required this.email,
        required this.mobile,
        required this.password,
        required this.createAt});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map[DbHelper.Table_Id],
        username: map[DbHelper.Table_Column_UserName],
        email: map[DbHelper.Table_Column_Email],
        mobile: map[DbHelper.Table_Column_Mobile],
        password: map[DbHelper.Table_Column_Password],
        createAt: map[DbHelper.Table_Column_Created_At]);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.Table_Column_UserName: username,
      DbHelper.Table_Column_Email: email,
      DbHelper.Table_Column_Mobile: mobile,
      DbHelper.Table_Column_Password: password,
      DbHelper.Table_Column_Created_At: createAt,
    };
  }
}