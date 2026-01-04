import 'package:intl/intl.dart';

extension DateStringFormatter on String {
  String toDDMMYYYY() {
    try {
      // Parse the string to DateTime
      DateTime dateTime = DateTime.parse(this);

      // Format the DateTime to the desired format
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      // Handle the error, possibly return the original string or an error message
      return 'Invalid date format';
    }
  }

  String toYYYYMMDD() {
    try {
      // Parse the string to DateTime
      DateTime dateTime = DateTime.parse(this);

      // Format the DateTime to the desired format
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      // Handle the error, possibly return the original string or an error message
      return 'Invalid date format';
    }
  }

  String todMMMyyyy() {
    try {
      // Parse the string to DateTime
      DateTime dateTime = DateTime.parse(this);

      // Format the DateTime to the desired format
      return DateFormat('d MMM yyyy').format(dateTime);
    } catch (e) {
      // Handle the error, possibly return the original string or an error message
      return 'Invalid date format';
    }
  }

  static String convertTimestampToDay(num timestamp, String type) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
    String formattedString = DateFormat(type).format(dateTime);

    return formattedString;
  }
}
