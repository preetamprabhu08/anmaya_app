import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/screens/courses.dart';
import 'package:anmaya/screens/homepage.dart';
import 'package:anmaya/screens/signin.dart';
import 'package:anmaya/screens/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:anmaya/utils/deep_link_helper.dart';
import 'package:anmaya/screens/settings.dart';


void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/edtech/courses',
      builder: (context, state) => const CoursesPage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
  path: '/settings',
  builder: (context, state) => const SettingsPage(),
),
  ],
  // Enhanced redirect logic to handle all URI patterns
  redirect: (context, state) {
    final uri = Uri.parse(state.uri.toString());
    
    // Log the incoming URI for debugging
    debugPrint('Deep link URI: ${uri.toString()}');
    
    // Custom app scheme handling
    if (uri.scheme == 'anmaya' && uri.host == 'open') {
      final path = uri.path.isEmpty ? '/' : uri.path;
      debugPrint('Redirecting custom scheme to: $path');
      return path;
    }
    
    // Web URL handling (both http and https)
    if ((uri.scheme == 'http' || uri.scheme == 'https') && uri.host == 'anmaya.in') {
      final path = uri.path.isEmpty ? '/' : uri.path;
      debugPrint('Redirecting web URL to: $path');
      return path;
    }
    
    // Default case - no redirect needed
    return null;
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Anmaya Technologies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}


