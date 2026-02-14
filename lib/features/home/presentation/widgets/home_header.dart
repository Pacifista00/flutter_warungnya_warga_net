import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/features/auth/auth_provider.dart';
import 'package:flutter_warungnya_warga_net/features/auth/domain/auth_state.dart';
import 'package:go_router/go_router.dart';

class HeaderSection extends ConsumerWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final points =
        authState.status == AuthStatus.authenticated && user != null
            ? user['points'] ?? 0
            : 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 54, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, AppColors.danger]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              authState.status == AuthStatus.authenticated && user != null
                  ? InkWell(
                    onTap: () {
                      context.push('/profile');
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              user['photo'] != null
                                  ? NetworkImage(user['photo'])
                                  : null,
                          child:
                              user['photo'] == null
                                  ? Text(
                                    user['name'][0].toUpperCase(),
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          user['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                  : InkWell(
                    onTap: () {
                      context.go('/login');
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),

              const Spacer(),

              /// POIN
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      size: 18,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      points.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 1),

              /// KERANJANG
              IconButton(
                onPressed: () {
                  context.push('/cart');
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          TextField(
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                context.push('/produk?search=${Uri.encodeComponent(value)}');
              }
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
