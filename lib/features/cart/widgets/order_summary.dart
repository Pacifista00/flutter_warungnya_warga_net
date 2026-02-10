import 'package:flutter/material.dart';

class OrderSummaryCard extends StatefulWidget {
  const OrderSummaryCard({super.key});

  @override
  State<OrderSummaryCard> createState() => _OrderSummaryCardState();
}

class _OrderSummaryCardState extends State<OrderSummaryCard> {
  final TextEditingController _voucherController = TextEditingController();
  String? _voucherMessage;
  bool _voucherApplied = false;

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  void _applyVoucher() {
    if (_voucherController.text.trim().toUpperCase() == 'DISKON10') {
      setState(() {
        _voucherApplied = true;
        _voucherMessage = 'Voucher berhasil digunakan 🎉';
      });
    } else {
      setState(() {
        _voucherApplied = false;
        _voucherMessage = 'Kode voucher tidak valid';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Pesanan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          _summaryRow('Sub Total', 'Rp 250.000'),
          _summaryRow('Biaya Pengiriman', 'Rp 20.000'),
          _summaryRow(
            'Diskon',
            _voucherApplied ? '- Rp 25.000' : 'Rp 0',
            valueColor: _voucherApplied ? Colors.green : Colors.black,
          ),

          const Divider(height: 24),

          // 🎟️ FORM VOUCHER
          const Text('Voucher', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),

          // 📦 PILIH PENGIRIMAN
          const Text(
            'Pilih Pengiriman',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: 'regular',
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'regular',
                child: Text('Regular (2-3 hari)'),
              ),
              DropdownMenuItem(
                value: 'express',
                child: Text('Express (1 hari)'),
              ),
            ],
            onChanged: (value) {},
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _voucherController,
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
              SizedBox(
                height: 48,
                width: 100, // 🔥 WAJIB ADA
                child: ElevatedButton(
                  onPressed: _applyVoucher,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),

          if (_voucherMessage != null) ...[
            const SizedBox(height: 6),
            Text(
              _voucherMessage!,
              style: TextStyle(
                fontSize: 12,
                color: _voucherApplied ? Colors.green : Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, color: valueColor),
          ),
        ],
      ),
    );
  }
}
