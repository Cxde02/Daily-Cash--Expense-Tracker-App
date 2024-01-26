import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/themes.dart';
import 'package:flutter_application_1/components/expense_summary.dart';
import 'package:flutter_application_1/components/expense_tile.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/models/expense_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controllers
  final newExpenseNameController = TextEditingController();
  final newAmountControllerRs = TextEditingController();
  final newAmountControllerCents = TextEditingController();

  @override
  void initState() {
    super.initState();

    //prep data on start
    Provider.of<ExpenseData>(context, listen: false).pData();
  }

  //add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          'Add new expense',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.textColor,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontSize: 17),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense name
            TextField(
              cursorColor: AppColors.primaryColor,
              style: TextStyle(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontSize: 15),
              keyboardType: TextInputType.text,
              controller: newExpenseNameController,
              decoration: InputDecoration(
                labelText: 'Expense Name',
                labelStyle: TextStyle(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  color: Color.fromARGB(255, 46, 206, 171),
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2.0),
                ),
              ),
            ),

            SizedBox(height: 10), // Add some spacing between the text fields

            Row(
              children: [
                // Rs
                Expanded(
                  child: TextField(
                    cursorColor: AppColors.primaryColor,
                    style: TextStyle(
                        fontFamily: GoogleFonts.courierPrime().fontFamily,
                        fontSize: 17),
                    keyboardType: TextInputType.number,
                    controller: newAmountControllerRs,
                    decoration: InputDecoration(
                      labelText: 'Amount (Rs)',
                      labelStyle: TextStyle(
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        color: Color.fromARGB(255, 46, 206, 171),
                        fontSize: 13,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // Set your default color here
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.0), // Set your focused color here
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10), // Add some spacing between the text fields

                // Cents
                Expanded(
                  child: TextField(
                    cursorColor: AppColors.primaryColor,
                    style: TextStyle(
                        fontFamily: GoogleFonts.courierPrime().fontFamily,
                        fontSize: 17),
                    keyboardType: TextInputType.number,
                    controller: newAmountControllerCents,
                    decoration: InputDecoration(
                      labelText: 'Cents',
                      labelStyle: TextStyle(
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        color: Color.fromARGB(255, 46, 206, 171),
                        fontSize: 13,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // Set your default color here
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.0), // Set your focused color here
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          // Cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),

          // Save button
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // save
  void save() {
    if (newAmountControllerRs.text.isNotEmpty) {
      // add Rs + cents
      String cents = newAmountControllerCents.text.isEmpty
          ? "00"
          : newAmountControllerCents.text;
      String amount = '${newAmountControllerRs.text}.$cents';

      // Expense Item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
      );

      // Add the new item
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);

      Navigator.pop(context);
      clearControllers();
    }
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
    clearControllers();
  }

  //clear controllers (The text in textfields)
  void clearControllers() {
    newExpenseNameController.clear();
    newAmountControllerRs.clear();
    newAmountControllerCents.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: const Text(
              'Expense Tracker',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  letterSpacing: 0.5,
                  color: AppColors.accentColor),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: addNewExpense,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.accentColor,
            ),
          ),
          body: ListView(
            children: [
              //weekly summary
              ExpenseSummary(startOfWeek: value.StartOfWeekDate()),

              const SizedBox(
                height: 20,
              ),

              //expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  deleteExpense: (p0) =>
                      deleteExpense(value.getAllExpenseList()[index]),
                ),
              ),
            ],
          )),
    );
  }
}
