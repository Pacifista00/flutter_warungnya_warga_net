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

    /// ambil query param `from` sekali saja
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

    /// VALIDASI FORM
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

      await AppDialog.show(context, title: 'Error', message: message);

      if (e is EmailNotVerifiedException) {
        context.push('/verify-email', extra: e.email);
        return;
      }

      if (e is InvalidCredentialException) {
        await AppDialog.show(context, title: 'Login gagal', message: e.message);
        return;
      }
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

                          /// EMAIL
                          AppTextField(
                            label: 'Email',
                            hint: 'login@abcd.com',
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
                          const SizedBox(height: 24),

                          /// LOGIN BUTTON
                          AppButton(
                            text: _isLoading ? 'Loading...' : 'Login',
                            onPressed:
                                _isLoading
                                    ? null
                                    : () {
                                      _onLoginPressed();
                                    },
                          ),

                          const SizedBox(height: 24),

                          /// OR
                          const Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text('Or'),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// GOOGLE LOGIN (placeholder)
                          AppButton(
                            text: 'Login with Google',
                            onPressed: () {},
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
                                            context.push(
                                              '/register?from=$_from',
                                            );
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
