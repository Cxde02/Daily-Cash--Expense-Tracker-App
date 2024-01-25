import 'package:flutter_application_1/bar%20graph/individual_bar.dart';

class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData(
      {required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount,
      required this.sunAmount});

  List<IndividualBar> barData = [];

  //initialize bar
  void initBarData() {
    barData = [
      //mon
      IndividualBar(x: 0, y: monAmount),
      //tue
      IndividualBar(x: 1, y: tueAmount),
      //wed
      IndividualBar(x: 2, y: wedAmount),
      //thur
      IndividualBar(x: 3, y: thurAmount),
      //fri
      IndividualBar(x: 4, y: friAmount),
      //sat
      IndividualBar(x: 5, y: satAmount),
      //sun
      IndividualBar(x: 6, y: sunAmount),
    ];
  }
}
