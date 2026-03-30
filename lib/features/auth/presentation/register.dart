import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/ui/app_dialog.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_button.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_text_field.dart';
import 'package:flutter_warungnya_warga_net/features/auth/auth_controller_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onRegisterPressed() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      return AppDialog.show(
        context,
        title: 'Form belum lengkap',
        message: 'Semua field wajib diisi.',
      );
    }

    if (password != confirm) {
      return AppDialog.show(
        context,
        title: 'Password tidak sama',
        message: 'Password dan konfirmasi password harus sama.',
      );
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authControllerProvider)
          .register(
            name: name,
            email: email,
            password: password,
            passwordConfirmation: confirm,
          );

      if (!mounted) return;

      await AppDialog.show(
        context,
        title: 'Registrasi Berhasil',
        message:
            'Akun berhasil dibuat.\nSilakan login dan verifikasi akun anda',
        onPressed: () {
          Navigator.of(context).pop();
          context.push('/verify-email', extra: email);
        },
      );
    } catch (e) {
      if (!mounted) return;

      await AppDialog.show(
        context,
        title: 'Registrasi Gagal',
        message: 'Email sudah digunakan atau terjadi kesalahan.',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background polos sesuai LoginPage
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// LOGO (Sama dengan LoginPage)
                Image.asset(
                  'assets/images/logo/logo.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Warung Net",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),

                /// FORM SECTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daftar Akun',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// FULL NAME
                    AppTextField(
                      label: 'Nama Lengkap',
                      hint: 'John Doe',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),

                    /// EMAIL
                    AppTextField(
                      label: 'Email',
                      hint: 'nama@email.com',
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),

                    /// PASSWORD
                    AppTextField(
                      label: 'Password',
                      hint: '********',
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 16),

                    /// CONFIRM PASSWORD
                    AppTextField(
                      label: 'Konfirmasi Password',
                      hint: '********',
                      obscureText: true,
                      controller: _confirmPasswordController,
                    ),
                    const SizedBox(height: 32),

                    /// TOMBOL REGISTER
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: AppButton(
                        text: _isLoading ? 'Memproses...' : 'DAFTAR',
                        onPressed: _isLoading ? null : _onRegisterPressed,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// FOOTER LINK
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Sudah mempunyai akun? ',
                          style: TextStyle(color: Colors.grey.shade600),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push('/login');
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
    );
  }
}
