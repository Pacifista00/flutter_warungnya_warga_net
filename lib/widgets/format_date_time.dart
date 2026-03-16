import 'package:intl/intl.dart';

String formatDateTime(String isoDate) {
  final date = DateTime.parse(isoDate).toLocal();
  return DateFormat('dd MMM yyyy HH:mm').format(date);
}
