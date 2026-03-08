import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/bottom_nav.dart';
import 'package:flutter_warungnya_warga_net/features/voucher/data/voucher_remote_datasource.dart';
import 'package:flutter_warungnya_warga_net/features/voucher/widgets/voucher_list_skeleton.dart';
import 'package:flutter_warungnya_warga_net/widgets/app_app_bar.dart';
import '../widgets/voucher_card.dart';
import 'package:go_router/go_router.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = VoucherRemoteDatasource();

    return Scaffold(
      appBar: AppAppBar(
        title: 'Voucher',
        onCartPressed: () {
          context.push('/cart');
        },
      ),
      body: FutureBuilder(
        future: datasource.getVouchers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const VoucherListSkeleton();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan'));
          }

          final vouchers = snapshot.data ?? [];

          if (vouchers.isEmpty) {
            return const Center(child: Text('Voucher tidak tersedia'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vouchers.length,
            itemBuilder: (context, index) {
              final voucher = vouchers[index];

              return InkWell(
                onTap: () {
                  context.push('/voucher/${voucher.id}');
                },
                child: VoucherCard(
                  title: voucher.name,
                  code: voucher.code,
                  description: 'Min belanja Rp${voucher.minOrderAmount}',
                  isActive: voucher.isActive,
                  onUse: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Voucher ${voucher.code} digunakan'),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
