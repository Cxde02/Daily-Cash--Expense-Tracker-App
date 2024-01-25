import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

class HiveDataBase {
  //ref
  final _myBox = Hive.box("expense_db");

  //write data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      //convert each expenseItem into a list of storable types(strings, dateTime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    //Store in db
    _myBox.put('ALL_EXPENSES', allExpensesFormatted);
  }

  //read data
}
