class VoucherModel {
  final String id;
  final String code;
  final String name;
  final String type;
  final int value;
  final int maxDiscount;
  final int minOrderAmount;
  final int? usageLimit;
  final int usageCount;
  final String startsAt;
  final String expiresAt;
  final bool isActive;

  VoucherModel({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.value,
    required this.maxDiscount,
    required this.minOrderAmount,
    required this.usageLimit,
    required this.usageCount,
    required this.startsAt,
    required this.expiresAt,
    required this.isActive,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      type: json['type'],
      value: json['value'],
      maxDiscount: json['max_discount'],
      minOrderAmount: json['min_order_amount'],
      usageLimit: json['usage_limit'],
      usageCount: json['usage_count'],
      startsAt: json['starts_at'],
      expiresAt: json['expires_at'],
      isActive: json['is_active'] == 1,
    );
  }
}
