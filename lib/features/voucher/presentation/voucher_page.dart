import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/bottom_nav.dart';
import 'package:flutter_warungnya_warga_net/widgets/app_app_bar.dart';
import '../widgets/voucher_card.dart';
import 'package:go_router/go_router.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// DUMMY DATA (nanti ganti API)
    final vouchers = [
      {
        'title': 'Diskon 10%',
        'code': 'KEMIKA10',
        'desc': 'Potongan 10% untuk semua produk',
        'active': true,
      },
      {
        'title': 'Gratis Ongkir',
        'code': 'ONGKIRFREE',
        'desc': 'Gratis ongkir minimal belanja Rp50.000',
        'active': true,
      },
      {
        'title': 'Diskon 20%',
        'code': 'SALE20',
        'desc': 'Voucher sudah kadaluarsa',
        'active': false,
      },
    ];

    return Scaffold(
      appBar: AppAppBar(
        title: 'Voucher',
        onCartPressed: () {
          context.push('/cart');
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return InkWell(
            onTap: () {
              context.push('/voucher/123');
            },
            child: VoucherCard(
              title: voucher['title'] as String,
              code: voucher['code'] as String,
              description: voucher['desc'] as String,
              isActive: voucher['active'] as bool,
              onUse: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Voucher ${voucher['code']} digunakan'),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
