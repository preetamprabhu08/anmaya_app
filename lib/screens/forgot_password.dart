import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/widgets/static/bottom_navbar.dart';
import 'package:anmaya/widgets/static/sidebar.dart';
import 'package:anmaya/utils/toast_helper.dart';
import 'package:anmaya/app_colors.dart';
import 'package:anmaya/provider/auth_provider.dart';
import 'package:provider/provider.dart';


class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),
      drawer: const Sidebar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const Icon(Icons.lock_reset, size: 48, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.text1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email address to receive a password reset link.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.text1),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.text1,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: AppColors.text1,
                      fontWeight:
                          FontWeight.bold, // optional, makes it stand out
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text('Send Mail'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    if (email.isEmpty) {
                      ToastHelper.warning(
                        'Please enter your email address',
                      );
                      return;
                    }
                    try {
                      await Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).sendPasswordResetEmail(email);
                      ToastHelper.info(
                        'Password reset email sent. Check your inbox!',
                      );
                    } catch (e) {
                      ToastHelper.error('Failed to send reset email: $e');
                    }
                  },
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('back to'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/signin');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
