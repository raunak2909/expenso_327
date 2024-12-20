import 'package:expense_app_ui/data/local/model/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'model/user_model.dart';

/// tables
/// 1 user (uid, uname, pass, email, mobno, createdAt)
/// 2 expense(eid, uid, etype[1-> debit, 2-> credit....], title, desc, createdAt, amt, balance, cat_id,)
/// 3 cat(cat_id, name, imgPath)
///
/// Database
/// 2 models
/// fromMap and toMap

///Tables
/// 1 user(uid,uname,pass,email,mobno,createdAt)
/// expense(eid,uid[as a foren key] etype[1->debit, 2->credit..],title,desc,createdAt,amt,balance,cat id,)
/// 2 models

class DbHelper {
  //private constructor
  DbHelper._();

  static final instance = DbHelper._();

  Database? uDB;

  static final String Table_User = "user";
  static final String Table_Id = "u_id";
  static final String Table_Column_UserName = "u_name";
  static final String Table_Column_Email = "u_email";
  static final String Table_Column_Mobile = "u_mobile";
  static final String Table_Column_Password = "u_password";
  static final String Table_Column_Created_At = "u_created_at";

  ////expense table
  static final String Expense_Table = "expense";
  static final String Expense_Id = "e_id";
  static final String Table_User_Id = "u_id";
  static final String Expense_Column_Table_Type = "e_type";
  static final String Expense_Column_Title = "e_title";
  static final String Expense_Column_Description = "e_desc";
  static final String Expense_Column_createdAt = "e_created_at";
  static final String Expense_Column_amount = "amount";
  static final String Expense_Column_balance = "balance";
  static final String Expense_Column_Cat_Id = "e_cat_id";

  ///First initial the database when database create
  Future<Database> initDB() async {
    uDB = uDB ?? await openDb();
    return uDB!;
  }

  ///openDb
  Future<Database> openDb() async {
    var appDir = await getApplicationDocumentsDirectory();
    var dbpath = join(appDir.path, "expenseDB.db");
    return openDatabase(dbpath, version: 1, onCreate: (db, version) {
      print("Db created");
      db.execute(
          "create table $Table_User ( $Table_Id integer primary key autoincrement, $Table_Column_UserName text not null, $Table_Column_Email text not null, $Table_Column_Mobile text not null, $Table_Column_Password text not null, $Table_Column_Created_At text not null)");

      db.execute(
          "create table $Expense_Table ( $Expense_Id integer primary key autoincrement, $Table_User_Id integer, $Expense_Column_Table_Type text, $Expense_Column_Title text not null, $Expense_Column_Description text not null, $Expense_Column_createdAt text not null, $Expense_Column_amount real not null, $Expense_Column_balance real, $Expense_Column_Cat_Id integer )" );

    });
  }

  Future<bool> checkIfEmailAlreadyExists({required String email}) async {
    var db = await initDB();

    List<Map<String, dynamic>> data =
        await db.query(Table_User, where: "$Table_Column_Email = ?", whereArgs: [email]);

    return data.isNotEmpty;
  }

  Future<bool> registerUser({required UserModel newUser}) async {
    var db = await initDB();

    int rowsEffected = await db.insert(Table_User, newUser.toMap());
    return rowsEffected > 0;

    /*if(!await checkIfEmailAlreadyExists(email: newUser.email)){
      int rowsEffected = await db.insert(Table_User, newUser.toMap());
      return rowsEffected>0;
    } else {
      return false;
    }*/
  }

  Future<bool> authenticateUser({required String email, required String pass}) async {
    var db = await initDB();

    List<Map<String, dynamic>> mData = await db.query(Table_User,
        where: "$Table_Column_Email = ? AND  $Table_Column_Password = ?",
        whereArgs: [email, pass]);

    /// saving userid in prefs
    if(mData.isNotEmpty){
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", mData[0][Table_Id].toString());
    }

    return mData.isNotEmpty;

  }

  Future<bool> addExpense(ExpenseModel newExpense) async{

    var db = await initDB();
    /*var prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("userId") ?? "";

    newExpense.userId = uid;*/

    int rowEffected = await db.insert(Expense_Table, newExpense.toMap());

    return rowEffected>0;
  }

  Future<List<ExpenseModel>> getAllExp() async{

    var db = await initDB();

    List<Map<String,dynamic>> mData = await db.query(Expense_Table);
    List<ExpenseModel> allExp = [];

    for(Map<String, dynamic> eachExp in mData){
      allExp.add(ExpenseModel.forMap(eachExp));
    }

    return allExp;

  }



/*Future<bool> addUser(UserModel newUser)async{
    Database db = await initDB();
    int rowseffected = await db.insert(Table_User, newUser.toMap());
    print("Rows effected");
    return rowseffected>0;
  }



  Future<List<UserModel>> fetchUser()async{
    Database db = await initDB();
    List<UserModel> uTask = [];
    List<Map<String,dynamic>> allUser = await db.query(Table_User);
    for(Map<String,dynamic> eachData in allUser){
      UserModel eachUser = UserModel.fromMap(eachData);
      uTask.add(eachUser);
    }
    return uTask;
  }*/
}
