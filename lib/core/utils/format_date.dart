import 'package:intl/intl.dart';

String formatDateWithHours(DateTime date) {
  DateTime now = DateTime.now().toLocal();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime inputDate = DateTime(date.year, date.month, date.day);
  if (inputDate == today) {
    return "Hoje ${DateFormat("'às' HH:mm").format(date)}";
  } else {
    return DateFormat("dd/MM 'às' HH:mm").format(date);
  }
}

String formatDate(DateTime date) {
  String month = DateFormat('MMM', 'pt_BR').format(date);
  return month[0].toUpperCase() + month.substring(1);
}
