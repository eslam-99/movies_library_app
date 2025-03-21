import 'package:intl/intl.dart';

String formatDate(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd MMM, yyyy').format(parsedDate);
  } catch (e) {
    return date;
  }
}

String formatRating(double rating) {
  return rating.toStringAsFixed(1);
}
