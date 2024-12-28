import 'package:expense_app_ui/data/local/model/expense_model.dart';

class FilterExpenseModel {
  String typeName;
  num totalAmt;
  List<ExpenseModel> allExpenses;

  FilterExpenseModel(
      {required this.typeName,
      required this.totalAmt,
      required this.allExpenses});
}
