import 'package:flutter/material.dart';
import 'package:anmaya/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      // debugShowCheckedModeBanner: false,
      title: 'Anmaya Technologies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}


