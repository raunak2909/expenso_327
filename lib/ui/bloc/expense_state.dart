import 'package:expense_app_ui/data/local/model/expense_model.dart';

abstract class ExpenseState{}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseLoadedState extends ExpenseState{
  List<ExpenseModel> mExp;
  ExpenseLoadedState({required this.mExp});
}
class ExpenseErrorState extends ExpenseState{
  String errorMsg;

  ExpenseErrorState({required this.errorMsg});
}