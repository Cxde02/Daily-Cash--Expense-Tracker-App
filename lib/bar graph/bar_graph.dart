import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bar%20graph/bar_data.dart';
import 'package:flutter_application_1/colors/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  @override
  Widget build(BuildContext context) {
    //init bar data
    BarData myBarData = BarData(
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
      sunAmount: sunAmount,
    );
    myBarData.initBarData();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: BarChart(
        BarChartData(
          maxY: maxY,
          minY: 0,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 23,
                  getTitlesWidget: getBottomTitles),
            ),
          ),
          barGroups: myBarData.barData
              .map(
                (data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: AppColors.primaryColor,
                      width: 25,
                      borderRadius: BorderRadius.circular(50),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxY,
                          color: const Color.fromARGB(255, 182, 248, 234)),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: AppColors.textColor,
    fontFamily: GoogleFonts.openSans().fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  // Assuming currentDate is the actual date
  DateTime currentDate = DateTime.now();
  int currentDayOfWeek = currentDate.weekday;

  Widget text;

  switch (value.toInt()) {
    case 0:
      text = _buildDayText('M', style, currentDayOfWeek == 1);
      break;
    case 1:
      text = _buildDayText('T', style, currentDayOfWeek == 2);
      break;
    case 2:
      text = _buildDayText('W', style, currentDayOfWeek == 3);
      break;
    case 3:
      text = _buildDayText('T', style, currentDayOfWeek == 4);
      break;
    case 4:
      text = _buildDayText('F', style, currentDayOfWeek == 5);
      break;
    case 5:
      text = _buildDayText('S', style, currentDayOfWeek == 6);
      break;
    case 6:
      text = _buildDayText('S', style, currentDayOfWeek == 7);
      break;
    default:
      text = Text(
        '',
        style: style,
      );
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget _buildDayText(String day, TextStyle style, bool isCurrentDay) {
  return Text(
    day,
    style: isCurrentDay
        ? style.copyWith(
            color: AppColors
                .primaryColor) // Change color to red for the current day
        : style,
  );
}
