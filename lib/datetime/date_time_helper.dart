//To convert the date to a string
String convertDateTimeToString(DateTime dateTime) {
  //yr -> yyyy
  String year = dateTime.year.toString();
  //mnth --> mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }
  //days --> dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }

  //final format --> ddmmyyyy
  String ddmmyyyy = '$day-$month-$year';

  return ddmmyyyy;
}
