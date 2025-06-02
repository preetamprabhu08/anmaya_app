import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:anmaya/routes/routes.dart';
import 'package:anmaya/app_colors.dart';
import 'package:anmaya/provider/auth_provider.dart'; // <-- Your AuthProvider

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(const AnmayaApp());
}

class AnmayaApp extends StatelessWidget {
  const AnmayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // ChangeNotifierProvider(create: (_) => UserProvider()),
        // ChangeNotifierProvider(create: (_) => CourseProvider()),
        // Add more providers here as needed
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Anmaya Technologies',
        theme: ThemeData(
          primaryColor: AppColors.primary2,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary2,
            foregroundColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppColors.accent1,
            primary: AppColors.primary1,
            background: AppColors.background,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.text1),
            bodyMedium: TextStyle(color: AppColors.text1),
          ),
        ),
      ),
    );
  }
}
