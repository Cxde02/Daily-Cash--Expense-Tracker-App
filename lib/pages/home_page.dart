import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add new expense'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          borderRadius: BorderRadius.circular(
              50.0), // Set your desired border radius here
        ),
        child: Icon(
          Icons.add,
          color: AppColors.accentColor,
        ),
      ),
    );
  }
}
