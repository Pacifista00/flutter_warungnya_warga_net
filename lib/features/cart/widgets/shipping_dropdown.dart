import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/widgets/skeleton/cart_skeleton.dart';
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
      return const ShippingDropdownSkeleton();
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
          style: TextStyle(fontSize: 14, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50), // 🔹 capsule
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
          ),
          items:
              shippingList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    "${option.courierName} - ${option.serviceName} "
                    "(${option.duration}) - Rp ${option.price}",
                    style: const TextStyle(fontSize: 14),
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
