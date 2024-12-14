
import 'package:expense_app_ui/domain/app_constants.dart';
import 'package:expense_app_ui/ui/on_boarding/login_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.APP_NAME,
      home: LoginPage(),
    );
  }
}