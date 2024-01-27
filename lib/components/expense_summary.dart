import 'package:flutter/material.dart';
import 'package:flutter_application_1/bar%20graph/bar_graph.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/datetime/date_time_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    Key? key,
    required this.startOfWeek,
  }) : super(key: key);

  double calculateMax(
    ExpenseData value,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];

    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  String calculateDailyTotal(ExpenseData value, String day) {
    double amount = value.calculateDailyExpenseSummary()[day] ?? 0;
    return amount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
            child: Row(
              children: [
                Text(
                  'Week Total: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),
                Text(
                  'Rs ${calculateWeekTotal(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday)}',
                  style: TextStyle(
                      fontFamily: GoogleFonts.abel().fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          // Daily Total
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
            child: Row(
              children: [
                Text(
                  'Today\'s Expense (${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('d MMM').format(DateTime.now())}): ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),
                Text(
                  'Rs ${calculateDailyTotal(value, convertDateTimeToString(DateTime.now()))}',
                  style: TextStyle(
                      fontFamily: GoogleFonts.abel().fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, monday, tuesday, wednesday, thursday,
                  friday, saturday, sunday),
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
