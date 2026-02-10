import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class VoucherForm extends StatelessWidget {
  const VoucherForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // INPUT
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan kode voucher',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // APPLY BUTTON
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {},
                child: const Text('Apply'),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // STATUS (OPSIONAL)
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Voucher berhasil digunakan 🎉',
            style: TextStyle(color: Colors.green, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
