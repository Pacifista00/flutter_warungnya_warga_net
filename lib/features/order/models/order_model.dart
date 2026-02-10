import '../../../core/constant/order_status.dart';

class Order {
  final String code;
  final DateTime date;
  final String expedition;
  final int total;
  final OrderStatus status;

  Order({
    required this.code,
    required this.date,
    required this.expedition,
    required this.total,
    required this.status,
  });
}
