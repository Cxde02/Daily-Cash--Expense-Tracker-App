import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/themes.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor.withOpacity(0.7),
        content: Text(
          'Slide to delete',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            color: AppColors.textColor,
          ),
        ),
        duration: const Duration(milliseconds: 700),
      ),
    );
  }

  void _onTileTap(BuildContext context) {
    _showSnackBar(context);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // delete btn
          SlidableAction(
            onPressed: deleteExpense,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
          ),
        ],
      ),
      child: ListTile(
        onTap: () => _onTileTap(context),
        title: Text(
          name,
          style: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          '${DateFormat('EEEE').format(dateTime)}, ${dateTime.day}-${DateFormat('MMM').format(dateTime)}-${dateTime.year}',
          style: TextStyle(
            fontFamily: GoogleFonts.barlow().fontFamily,
            fontSize: 10,
            color: const Color.fromARGB(172, 29, 29, 29),
          ),
        ),
        trailing: Text(
          'Rs $amount',
          style: const TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.w900,
            fontSize: 11.5,
          ),
        ),
      ),
    );
  }
}
