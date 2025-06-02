import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/app_colors.dart';


class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Remove width parameter to use default width
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary2,
            ),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Menu', style: TextStyle(color: AppColors.text1, fontSize: 24)),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.text1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              context.push('/home'); // Navigate using pushRouter
            },
          ),
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('Explore'),
            onTap: () {
              context.push('/programs');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              context.push('/profile');
              Navigator.pop(context);
            },
          ),
           ListTile(
            leading: const Icon(Icons.login),
            title: const Text('sign in'),
            onTap: () {
              context.push('/signin');
              Navigator.pop(context);
            },
          ),
           ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('settings'),
            onTap: () {
              context.push('/settings');
              Navigator.pop(context);
            },
          ),
           ListTile(
            leading: const Icon(Icons.help),
            title: const Text('help'),
            onTap: () {
              context.push('/help');
              Navigator.pop(context);
            },
          ),          
        ],
      ),
    );
  }
}