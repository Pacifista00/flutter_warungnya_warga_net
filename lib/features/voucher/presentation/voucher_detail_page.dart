import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/voucher/data/voucher_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/voucher/models/voucher_model.dart';
import 'package:flutter_warungnya_warga_net/features/voucher/widgets/voucher_detail_skeleton.dart';

class VoucherDetailPage extends StatelessWidget {
  final String voucherId;

  const VoucherDetailPage({super.key, required this.voucherId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Detail Voucher'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder<VoucherModel>(
        future: VoucherRemoteDatasource().getVoucherById(voucherId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const VoucherDetailSkeleton();
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat voucher'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Voucher tidak ditemukan'));
          }

          final voucher = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // ================= HEADER =================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Voucher Belanja',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        voucher.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CODE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Kode Voucher',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                voucher.code,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Column(
                          children: [
                            _infoRow(
                              'Diskon',
                              voucher.type == 'percentage'
                                  ? '${voucher.value}%'
                                  : 'Rp ${voucher.value}',
                            ),
                            _infoRow(
                              'Maks. Diskon',
                              'Rp ${voucher.maxDiscount}',
                            ),
                            _infoRow(
                              'Min. Belanja',
                              'Rp ${voucher.minOrderAmount}',
                            ),
                            _infoRow('Berlaku Sampai', voucher.expiresAt),
                          ],
                        ),

                        const Divider(height: 32),

                        const Text(
                          'Deskripsi',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          voucher.description ?? '-',
                          style: const TextStyle(height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),

      // // ================= BUTTON =================
      // bottomNavigationBar: SafeArea(
      //   child: Container(
      //     padding: const EdgeInsets.all(16),
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black.withOpacity(0.05),
      //           blurRadius: 10,
      //           offset: const Offset(0, -2),
      //         ),
      //       ],
      //     ),
      //     child: SizedBox(
      //       width: double.infinity,
      //       height: 48,
      //       child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: AppColors.primary,
      //         ),
      //         onPressed: () {
      //           // TODO: apply voucher logic
      //           Navigator.pop(context);
      //         },
      //         child: const Text(
      //           'Gunakan Voucher',
      //           style: TextStyle(fontSize: 16),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
