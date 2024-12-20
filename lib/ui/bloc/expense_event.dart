import 'package:expense_app_ui/data/local/model/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExp;
  AddExpenseEvent({required this.newExp});
}

class FetchInitialExpenseEvent extends ExpenseEvent{}