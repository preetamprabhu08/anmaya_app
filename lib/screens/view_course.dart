import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/widgets/static/bottom_navbar.dart';
import 'package:anmaya/widgets/static/sidebar.dart';
import 'package:anmaya/utils/toast_helper.dart';


class ViewCoursePage extends StatelessWidget {
  const ViewCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Move toast call here
    return Scaffold(
      appBar: AppBar(
        title: const Text('view course'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const Sidebar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('view course'),
            const SizedBox(height: 20),
            
            ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
