import 'dart:core';

import 'package:flutter_application_1/datetime/date_time_helper.dart';
import 'package:flutter_application_1/models/expense_item.dart';

class ExpenseData {
  //list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
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
  DateTime StartOfWeekDate() {
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
