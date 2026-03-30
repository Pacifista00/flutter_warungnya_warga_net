import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/ui/app_dialog.dart';
import 'package:flutter_warungnya_warga_net/features/auth/domain/auth_exceptions.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/router/route_rules.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_text_field.dart';
import 'package:flutter_warungnya_warga_net/features/auth/auth_controller_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  late String _from;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uri = GoRouterState.of(context).uri;
    _from = uri.queryParameters['from'] ?? '/home';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      await AppDialog.show(
        context,
        title: 'Form belum lengkap',
        message: 'Silakan isi email dan password terlebih dahulu.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authControllerProvider)
          .login(email: email, password: password);

      if (!mounted) return;
      context.push(_from);
    } catch (e) {
      if (!mounted) return;
      final message = e is AuthException ? e.message : 'Terjadi kesalahan.';

      if (e is EmailNotVerifiedException) {
        context.push('/verify-email', extra: e.email);
        return;
      }

      await AppDialog.show(context, title: 'Login Gagal', message: message);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final isFromProtected = protectedRoutes.any(
          (route) => _from.startsWith(route),
        );
        context.push(isFromProtected ? '/home' : _from);
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Background polos total
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// LOGO LANGSUNG DI ATAS
                  Image.asset(
                    'assets/images/logo/logo.png',
                    height:
                        120, // Ukuran logo sedikit diperbesar agar proporsional
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Wawanet",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 48),

                  /// FORM LOGIN TANPA SHADOW BERLEBIH (MINIMALIS)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),

                      /// FIELD EMAIL
                      AppTextField(
                        label: 'Email',
                        hint: 'Masukkan email Anda',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),

                      /// FIELD PASSWORD
                      AppTextField(
                        label: 'Password',
                        hint: 'Masukkan password',
                        obscureText: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 32),

                      /// TOMBOL LOGIN
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: AppButton(
                          text: _isLoading ? 'Memproses...' : 'MASUK',
                          onPressed: _isLoading ? null : _onLoginPressed,
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// LINK DAFTAR
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Belum punya akun? ",
                            style: TextStyle(color: Colors.grey.shade600),
                            children: [
                              TextSpan(
                                text: 'Daftar Sekarang',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        context.push('/register?from=$_from');
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
