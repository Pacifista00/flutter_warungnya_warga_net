class ShippingModel {
  final String courierCode;
  final String courierServiceCode;
  final String courierName;
  final String serviceName;
  final String duration;
  final int price;

  ShippingModel({
    required this.courierCode,
    required this.courierServiceCode,
    required this.courierName,
    required this.serviceName,
    required this.duration,
    required this.price,
  });

  factory ShippingModel.fromJson(Map<String, dynamic> json) {
    return ShippingModel(
      courierCode: json['courier_code'],
      courierServiceCode: json['courier_service_code'],
      courierName: json['courier_name'],
      serviceName: json['courier_service_name'],
      duration: json['duration'],
      price: json['price'],
    );
  }
}
