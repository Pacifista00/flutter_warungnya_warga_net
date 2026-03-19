import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/cart/services/voucher_services.dart';

class VoucherForm extends StatefulWidget {
  final void Function(int discount, String? code)? onApplied;

  const VoucherForm({super.key, this.onApplied});

  @override
  State<VoucherForm> createState() => _VoucherFormState();
}

class _VoucherFormState extends State<VoucherForm> {
  Map<String, dynamic>? voucher;
  int discount = 0;
  final TextEditingController controller = TextEditingController();
  final VoucherService service = VoucherService();

  String? message;
  bool success = false;
  bool loading = false;
  String _format(int value) {
    return "Rp ${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}";
  }

  Future<void> applyVoucher() async {
    setState(() {
      loading = true;
      message = null;
    });

    try {
      final result = await service.previewVoucher(controller.text);

      setState(() {
        success = true;
        voucher = result['voucher'];
        discount = result['discount'];
        message = "Voucher berhasil digunakan 🎉";
      });

      widget.onApplied?.call(discount, voucher!['code']);
    } catch (e) {
      setState(() {
        success = false;
        voucher = null;
        discount = 0;
        message = "Voucher tidak valid";
      });
    }

    setState(() {
      loading = false;
    });
  }

  void removeVoucher() {
    setState(() {
      voucher = null;
      discount = 0;
      controller.clear();
      message = null;
      success = false;
    });

    widget.onApplied?.call(0, null); // 🔥 kirim reset ke parent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
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

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 48), // penting
              ),
              onPressed: loading ? null : applyVoucher,
              child:
                  loading
                      ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text('Apply'),
            ),
          ],
        ),

        const SizedBox(height: 8),

        if (message != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              message!,
              style: TextStyle(
                color: success ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        if (voucher != null)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                /// 🔹 INFO VOUCHER
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucher!['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Kode: ${voucher!['code']}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        voucher!['type'] == 'percentage'
                            ? "Potongan: ${voucher!['value']}%"
                            : "Potongan: ${_format(voucher!['value'])}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                /// 🔹 DISKON
                Text(
                  "- ${_format(discount)}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 8),

                /// 🔥 TOMBOL X (REMOVE)
                InkWell(
                  onTap: removeVoucher,
                  child: const Icon(Icons.close, size: 18, color: Colors.red),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
