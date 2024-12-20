
import 'package:expense_app_ui/data/local/db_helper.dart';
import 'package:expense_app_ui/domain/app_constants.dart';
import 'package:expense_app_ui/ui/bloc/expense_bloc.dart';
import 'package:expense_app_ui/ui/home_page.dart';
import 'package:expense_app_ui/ui/on_boarding/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(BlocProvider(
    create: (context) => ExpenseBloc(dbHelper: DbHelper.instance),
      child: Myapp()));
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
    //getPrefsValue();
  }



  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: AppConstants.APP_NAME,
      home: HomePage(),
    );
  }
}