import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {  // Ensure class name is SignInPage
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: const Center(child: Text('Sign In Page')),
    );
  }
}