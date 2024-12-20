
import 'package:expense_app_ui/data/local/db_helper.dart';

class ExpenseModel {
  int? id;
  int userId;
  String expenseType;
  String title;
  String desc;
  String createdAt;
  double amount;
  double balance;
  int categoryId;

  ExpenseModel(
      {this.id,
        required this.userId,
        required this.expenseType,
        required this.title,
        required this.desc,
        required this.createdAt,
        required this.amount,
        required this.balance,
        required this.categoryId});

  factory ExpenseModel.forMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map[DbHelper.Expense_Id],
        userId: map[DbHelper.Table_User_Id],
        expenseType: map[DbHelper.Expense_Column_Table_Type],
        title: map[DbHelper.Expense_Column_Title],
        desc: map[DbHelper.Expense_Column_Description],
        createdAt: map[DbHelper.Expense_Column_createdAt],
        amount: map[DbHelper.Expense_Column_amount],
        balance: map[DbHelper.Expense_Column_balance],
        categoryId: map[DbHelper.Expense_Column_Cat_Id]);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.Table_User_Id: userId,
      DbHelper.Expense_Column_Table_Type: expenseType,
      DbHelper.Expense_Column_Title: title,
      DbHelper.Expense_Column_Description: desc,
      DbHelper.Expense_Column_createdAt: createdAt,
      DbHelper.Expense_Column_amount: amount,
      DbHelper.Expense_Column_balance: balance,
      DbHelper.Expense_Column_Cat_Id: categoryId,
    };
  }
}
