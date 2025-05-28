import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:anmaya/screens/explore.dart';
import 'package:anmaya/screens/home_page.dart';
import 'package:anmaya/screens/signin.dart';
import 'package:anmaya/screens/signup.dart';
import 'package:anmaya/server_check.dart';
import 'package:anmaya/screens/profile.dart';


/// Global router configuration for the app
final GoRouter router = GoRouter(
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
      path: '/server-check',
      builder: (context, state) => const ServerCheckPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/programs',
      builder: (context, state) => const CoursesPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
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