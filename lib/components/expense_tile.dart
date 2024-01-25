import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/themes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteExpense;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          //delete btn
          SlidableAction(
            onPressed: deleteExpense,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: AppColors.textColor),
        ),
        subtitle: Text(
          '${dateTime.day}-${DateFormat('MMM').format(dateTime)}-${dateTime.year}',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 11),
        ),
        trailing: Text(
          'Rs $amount',
          style: TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
              fontSize: 10.5),
        ),
      ),
    );
  }
}
