import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/shipping_model.dart';

class ShippingDropdown extends StatefulWidget {
  final Function(ShippingModel)? onChanged;

  const ShippingDropdown({super.key, this.onChanged});

  @override
  State<ShippingDropdown> createState() => _ShippingDropdownState();
}

class _ShippingDropdownState extends State<ShippingDropdown> {
  final CartService _service = CartService();

  List<ShippingModel> shippingList = [];
  ShippingModel? selected;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadShipping();
  }

  Future<void> loadShipping() async {
    try {
      final result = await _service.getShippingPreview();

      setState(() {
        shippingList = result;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (shippingList.isEmpty) {
      return const Text("Pengiriman tidak tersedia");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pilih Pengiriman",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),

        DropdownButtonFormField<ShippingModel>(
          value: selected,
          hint: const Text("Ketuk untuk memilih kurir"),
          items:
              shippingList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    "${option.courierName} - ${option.serviceName} "
                    "(${option.duration}) - Rp ${option.price}",
                  ),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              selected = value;
            });

            if (value != null) {
              widget.onChanged?.call(value);
            }
          },
        ),
      ],
    );
  }
}
