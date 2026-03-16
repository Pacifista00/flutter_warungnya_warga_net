class AddressModel {
  final String id;
  final String recipientName;
  final String phone;
  final String streetAddress;
  final String city;
  final String province;
  final String postalCode;
  final bool isDefault;
  final String biteshipLocationId;
  final String createdAt;

  AddressModel({
    required this.id,
    required this.recipientName,
    required this.phone,
    required this.streetAddress,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.isDefault,
    required this.biteshipLocationId,
    required this.createdAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      recipientName: json['recipient_name'] ?? '',
      phone: json['phone'] ?? '',
      streetAddress: json['street_address'] ?? '',
      city: json['city'] ?? '',
      province: json['province'] ?? '',
      postalCode: json['postal_code'] ?? '',
      isDefault: json['is_default'] ?? false,
      biteshipLocationId: json['biteship_location_id'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
