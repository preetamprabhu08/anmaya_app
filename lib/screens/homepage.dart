import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/utils/deep_link_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    
    // Show after a short delay when the app starts
    Future.delayed(Duration(seconds: 2), () {
      DeepLinkHelper.showEnableDeepLinksDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            ElevatedButton(
              onPressed: () => context.go('/signin'),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/signup'),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/edtech/courses'),
              child: const Text('Courses'),
            ),
            
          ],
        ),
      ),
    );
  }
}