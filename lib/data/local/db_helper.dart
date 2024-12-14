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

  ///First initial the database when database create
  Future<Database> initDB() async {
    uDB = uDB ?? await openDb();
    return uDB!;
  }

  ///openDb
  Future<Database> openDb() async {
    var appDir = await getApplicationCacheDirectory();
    var dbpath = join(appDir.path, "expenseDB.db");
    return openDatabase(dbpath, version: 1, onCreate: (db, version) {
      print("Db created");
      db.execute(
          "create table $Table_User ( $Table_Id integer primary key autoincrement, $Table_Column_UserName text not null, $Table_Column_Email text not null, $Table_Column_Mobile text not null, $Table_Column_Password text not null, $Table_Column_Created_At text not null)");
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
