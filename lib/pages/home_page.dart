import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/themes.dart';
import 'package:flutter_application_1/components/expense_summary.dart';
import 'package:flutter_application_1/components/expense_tile.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/models/expense_item.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              keyboardType: TextInputType.text,
              controller: newExpenseNameController,
              decoration: InputDecoration(labelText: 'Expense Name'),
            ),

            Row(
              children: [
                //Rs
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: newAmountControllerRs,
                    decoration: InputDecoration(labelText: 'Amount (Rs)'),
                  ),
                ),

                //Cents
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: newAmountControllerCents,
                    decoration: InputDecoration(labelText: 'Cents'),
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          //save button
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  // save
  void save() {
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
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clearControllers();
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
                    dateTime: value.getAllExpenseList()[index].dateTime),
              ),
            ],
          )),
    );
  }
}
