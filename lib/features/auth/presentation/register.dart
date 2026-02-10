import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_primary_button.dart';
import 'package:flutter_warungnya_warga_net/widgets/forms/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_warungnya_warga_net/core/theme/app_colors.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER BIRU
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

              /// CARD FORM
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
                            'Register',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        const AppTextField(
                          label: 'Full Name',
                          hint: 'John Doe',
                        ),
                        const SizedBox(height: 16),

                        const AppTextField(
                          label: 'Email',
                          hint: 'register@abcd.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        const AppTextField(
                          label: 'Password',
                          hint: '********',
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),

                        const AppTextField(
                          label: 'Confirm Password',
                          hint: '********',
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),

                        AppPrimaryButton(
                          text: 'Register',
                          onPressed: () {
                            // TODO: call register API
                            context.go('/verify-email');
                          },
                        ),

                        const SizedBox(height: 24),

                        /// FOOTER
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              style: const TextStyle(color: Colors.black),
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
                                          context.go('/login');
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
    );
  }
}
