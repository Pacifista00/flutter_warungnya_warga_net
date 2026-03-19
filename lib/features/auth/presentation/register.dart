import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_warungnya_warga_net/core/ui/app_dialog.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_primary_button.dart';
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

    /// VALIDASI FORM
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
          context.push(
            '/verify-email',
            extra: email, // email user
          );
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
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
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
                  child: Icon(Icons.person_add, size: 48, color: Colors.white),
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
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        AppTextField(
                          label: 'Full Name',
                          hint: 'John Doe',
                          controller: _nameController,
                        ),
                        const SizedBox(height: 16),

                        AppTextField(
                          label: 'Email',
                          hint: 'register@abcd.com',
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16),

                        AppTextField(
                          label: 'Password',
                          hint: '********',
                          obscureText: true,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 16),

                        AppTextField(
                          label: 'Confirm Password',
                          hint: '********',
                          obscureText: true,
                          controller: _confirmPasswordController,
                        ),
                        const SizedBox(height: 24),

                        AppPrimaryButton(
                          text: _isLoading ? 'Loading...' : 'Register',
                          onPressed: _isLoading ? null : _onRegisterPressed,
                        ),

                        const SizedBox(height: 24),

                        /// FOOTER
                        Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
