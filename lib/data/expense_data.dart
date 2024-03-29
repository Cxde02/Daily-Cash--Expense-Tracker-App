import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/hive_database.dart';
import 'package:flutter_application_1/datetime/date_time_helper.dart';
import 'package:flutter_application_1/models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //prepare data to display
  final db = HiveDataBase();
  void pData() {
    //if exists
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //get weekday
  String getDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  //get date for start of the week --> Monday
  // ignore: non_constant_identifier_names
  DateTime StartOfWeekDate() {
    // ignore: non_constant_identifier_names
    DateTime? StartOfWeek;

    //get today's date
    DateTime today = DateTime.now();

    //find monday from today by going backwards
    for (int i = 0; i < 7; i++) {
      if (getDay(today.subtract(Duration(days: i))) == 'Mon') {
        StartOfWeek = today.subtract(Duration(days: i));
      }
    }
    return StartOfWeek!;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //date dd-mm-yyyy : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
