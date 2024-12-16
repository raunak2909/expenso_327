import 'package:expense_app_ui/domain/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpPage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  String selectedExpenseType = "Debit";

  List<String> mExpenseType = ["Debit", "Credit", "Loan", "Lend", "Borrow"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            spacing: 11,
            children: [
              TextField(
                controller: titleController,
                decoration: mFieldDecor(
                    hint: "Enter title here..", heading: "Title"),
              ),
              TextField(
                controller: descController,
                decoration: mFieldDecor(
                    hint: "Enter desc here..", heading: "Desc"),
              ),
              TextField(
                controller: amtController,
                decoration: mFieldDecor(
                  mPrefixText: "\$ ",
                    hint: "Enter Amount here..", heading: "Amount"),
              ),

              /// expense type
              StatefulBuilder(builder: (_, ss){
                /*return DropdownButton(
                    value: selectedExpenseType,
                    items: mExpenseType.map((expenseType) {
                      return DropdownMenuItem(child: Text(expenseType), value: expenseType,);
                    }). toList(),
                    onChanged: (value){
                      selectedExpenseType = value ?? "Debit";
                      ss((){});
                    });*/

                return DropdownMenu(
                  width: double.infinity,
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(width: 1),
                    )
                  ),
                  initialSelection: selectedExpenseType,
                    onSelected: (value){
                    selectedExpenseType = value ?? "Debit";
                    },
                    dropdownMenuEntries: mExpenseType.map((expenseType){
                  return DropdownMenuEntry(value: expenseType, label: expenseType);
                }).toList());

              })
            ]
        ),
      ),
    );
  }
}