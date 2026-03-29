import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/ui/app_confirm_dialog.dart';
import 'package:flutter_warungnya_warga_net/features/auth/auth_controller_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/features/home/presentation/widgets/bottom_nav.dart';
import 'package:flutter_warungnya_warga_net/features/profile/widgets/profile.header.dart';
import 'package:flutter_warungnya_warga_net/features/profile/widgets/order_status_section.dart';
import 'package:flutter_warungnya_warga_net/features/profile/widgets/info_card.dart';
import 'package:flutter_warungnya_warga_net/features/profile/widgets/setting_item.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      body: Column(
        children: [
          const ProfileHeader(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const OrderStatusSection(),
                const SizedBox(height: 12),

                /// INFO CARD
                Row(
                  children: [
                    const Expanded(
                      child: InfoCard(
                        icon: Icons.monetization_on_outlined,
                        title: 'Poin',
                        value: '0',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          context.push('/voucher');
                        },
                        child: InfoCard(
                          icon: Icons.discount_outlined,
                          title: 'Voucher',
                          subtitle: 'Lihat Voucher',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  'Pengaturan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // const SettingItem(
                //   icon: Icons.settings_outlined,
                //   title: 'Pengaturan Akun',
                //   subtitle:
                //       'Ubah Kata Sandi, Tambah Alamat, Logout, dan lainnya',
                // ),
                SettingItem(
                  icon: Icons.location_on_outlined,
                  title: 'Alamat',
                  subtitle: 'Kelola alamat anda untuk pengiriman',
                  onTap: () {
                    context.push('/addresses');
                  },
                ),
                SettingItem(
                  icon: Icons.help_outline,
                  title: 'Pusat Bantuan',
                  subtitle:
                      'FAQ, Cara Belanja, Syarat & ketentuan, Hubungi Kami',
                  onTap: () {
                    context.push('/help');
                  },
                ),
                SettingItem(
                  icon: Icons.store_outlined,
                  title: 'Lokasi Kami',
                  subtitle: 'Temukan Gudang kami',
                  onTap: () {
                    context.push('/location');
                  },
                ),
                SettingItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Keluar dari akun ini',
                  isDestructive: true,
                  onTap: () async {
                    final confirm = await AppConfirmDialog.show(
                      context,
                      title: 'Logout',
                      message: 'Yakin ingin keluar dari akun?',
                      confirmText: 'Logout',
                      isDestructive: true,
                    );

                    if (confirm == true) {
                      await ref.read(authControllerProvider).logout();

                      if (context.mounted) {
                        context.push('/login');
                      }
                    }
                  },
                ),

                const SizedBox(height: 8),

                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'V 1.0.1',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }
}
