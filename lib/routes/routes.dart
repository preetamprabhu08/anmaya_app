import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:anmaya/screens/explore.dart';
import 'package:anmaya/screens/home_page.dart';
import 'package:anmaya/screens/signin.dart';
import 'package:anmaya/screens/signup.dart';
import 'package:anmaya/server_check.dart';
import 'package:anmaya/screens/profile.dart';
import 'package:anmaya/screens/help.dart';
import 'package:anmaya/screens/settings.dart';
import 'package:anmaya/screens/my_course.dart';
import 'package:anmaya/screens/wishlist.dart';
import 'package:anmaya/screens/contact.dart';
import 'package:anmaya/screens/course_details.dart';
import 'package:anmaya/screens/view_course.dart';
import 'package:anmaya/screens/forgot_password.dart';



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
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/my-course',
      builder: (context, state) => const MyCoursePage(),
    ),
    GoRoute(
      path: '/wishlists',
      builder: (context, state) => const WishlistPage(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactPage(),
    ),
    GoRoute(
      path: '/course-details',
      builder: (context, state) => const CourseDetailsPage(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/view-course',
      builder: (context, state) => const ViewCoursePage(),
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