class OrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final String shippingStatus; // baru
  final String paymentStatus;
  final String createdAtFormatted;

  final int subtotal;
  final int shippingCost;
  final int voucherDiscount;
  final int pointsDiscount;
  final int totalAmount;

  final Courier courier;
  final List<OrderItem> items;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.shippingStatus,
    required this.paymentStatus,
    required this.createdAtFormatted,
    required this.subtotal,
    required this.shippingCost,
    required this.voucherDiscount,
    required this.pointsDiscount,
    required this.totalAmount,
    required this.courier,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"] ?? '',
      orderNumber: json["order_number"] ?? '',
      status: json["status"] ?? '',
      shippingStatus: json["shipping_status"] ?? '',
      paymentStatus: json["payment_status"] ?? '',
      createdAtFormatted: json["created_at_formatted"] ?? '',
      subtotal: json["subtotal_amount"] ?? 0,
      shippingCost: json["shipping_cost"] ?? 0,
      voucherDiscount: json["voucher_discount"] ?? 0,
      pointsDiscount: json["points_discount"] ?? 0,
      totalAmount: json["total_amount"] ?? 0,
      courier:
          json["courier"] != null
              ? Courier.fromJson(json["courier"])
              : Courier(code: '', service: ''),
      items:
          (json["items"] as List<dynamic>? ?? [])
              .map((e) => OrderItem.fromJson(e))
              .toList(),
    );
  }
}

class Courier {
  final String code;
  final String service;

  Courier({required this.code, required this.service});

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(code: json["code"], service: json["service"]);
  }
}

class OrderItem {
  final int quantity;
  final int unitPrice;
  final int totalPrice;
  final String productName;
  final String imageUrl;

  OrderItem({
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.productName,
    required this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      quantity: json["quantity"] ?? 0,
      unitPrice: json["unit_price"] ?? 0,
      totalPrice: json["total_price"] ?? 0,
      productName: json["product"]?["name"] ?? '',
      imageUrl: json["product"]?["image_url"] ?? '',
    );
  }
}
