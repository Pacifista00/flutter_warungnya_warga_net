import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/config/env/prod_env.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/auth/auth_provider.dart';
import 'package:flutter_warungnya_warga_net/features/auth/domain/auth_state.dart';
import 'package:go_router/go_router.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  void _goToEditProfile(BuildContext context) {
    context.push('/profile/edit'); // arahkan ke halaman edit profile
  }

  void _goToEditPhoto(BuildContext context) {
    context.push('/profile/edit-photo'); // arahkan ke halaman edit foto
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Container(
      color: AppColors.primary,
      child: Column(
        children: [
          /// ================= APP BAR =================
          SafeArea(
            bottom: false,
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Text(
                    'Profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _goToEditProfile(context),
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          /// ================= HEADER CONTENT =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// AVATAR DENGAN TOMBOL EDIT FOTO
                Stack(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipOval(
                        child:
                            authState.status == AuthStatus.authenticated &&
                                    user != null &&
                                    user['photo'] != null
                                ? Image.network(
                                  "${ProdEnv.storageUrl}/${user['photo']}",
                                  fit: BoxFit.cover,
                                )
                                : const Icon(Icons.person, color: Colors.white),
                      ),
                    ),

                    // Tombol edit kecil di kanan bawah avatar
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _goToEditPhoto(context),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                /// USER INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authState.status == AuthStatus.authenticated &&
                                user != null
                            ? user['name'] ?? 'Tidak Diketahui'
                            : 'Guest',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authState.status == AuthStatus.authenticated &&
                                user != null
                            ? user['phone'] ?? '-'
                            : '-',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        authState.status == AuthStatus.authenticated &&
                                user != null
                            ? user['email'] ?? '-'
                            : '-',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
