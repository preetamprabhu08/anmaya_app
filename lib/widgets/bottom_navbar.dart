import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.blue,      // Active icon color
      unselectedItemColor: Colors.white, 
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _getCurrentIndex(context),
      onTap: (index) => _onItemTapped(index, context),
    );
  }

  static int _getCurrentIndex(BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.routeInformationProvider?.value.location ?? '/';
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/programs')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  static void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.push('/programs');
        break;
      case 2:
        context.push('/profile');
        break;
    }
  }
}