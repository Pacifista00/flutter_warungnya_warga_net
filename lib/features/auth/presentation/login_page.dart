import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/router/route_rules.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_primary_button.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 1. Ambil query parameter 'from'
    final uri = GoRouterState.of(context).uri;
    final from = uri.queryParameters['from'] ?? '/home';

    return PopScope(
      canPop: false, // Kita matikan back default untuk handle manual
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        /// 2. Logika "Safe Exit" agar tidak loop
        // Cek apakah halaman asal adalah protected
        final isFromProtected = protectedRoutes.any(
          (route) => from.startsWith(route),
        );

        if (isFromProtected) {
          // Jika asal dari /profile dsb, balik ke /produk (sesuai request kamu)
          context.go('/home');
        } else {
          // Jika asal dari halaman public, balik ke halaman tersebut
          context.go(from);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// HEADER (Sesuai UI kamu)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.lock, size: 48, color: Colors.white),
                  ),
                ),

                /// FORM CARD
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          const AppTextField(
                            label: 'Email',
                            hint: 'login@abcd.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),

                          const AppTextField(
                            label: 'Password',
                            hint: '********',
                            obscureText: true,
                          ),
                          const SizedBox(height: 24),

                          /// LOGIN BUTTON
                          AppPrimaryButton(
                            text: 'Login',
                            onPressed: () async {
                              // TODO: Integrasi Laravel Sanctum di sini
                              // Jika sukses:
                              context.go(from);
                            },
                          ),

                          const SizedBox(height: 24),

                          /// OR SEPARATOR
                          Row(
                            children: const [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text('Or'),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),

                          const SizedBox(height: 16),

                          AppPrimaryButton(
                            text: 'Login with Google',
                            onPressed: () {
                              // Logic Google Sign-In
                            },
                          ),

                          const SizedBox(height: 24),

                          /// REGISTER LINK
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Don't have any account? ",
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            // Teruskan parameter 'from' ke register
                                            context.go('/register?from=$from');
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
