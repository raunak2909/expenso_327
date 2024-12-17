
import 'package:expense_app_ui/domain/app_constants.dart';
import 'package:expense_app_ui/ui/home_page.dart';
import 'package:expense_app_ui/ui/on_boarding/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(Myapp());
}

class Myapp extends StatefulWidget{
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  String uid = "";
  @override
  void initState() {
    super.initState();
    getPrefsValue();
  }

  void getPrefsValue() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid") ?? "";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: AppConstants.APP_NAME,
      home: uid!= "" ? HomePage() : LoginPage(),
    );
  }
}