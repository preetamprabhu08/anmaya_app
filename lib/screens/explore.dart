import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/widgets/static/bottom_navbar.dart';
import 'package:anmaya/widgets/static/sidebar.dart';
import 'package:anmaya/firebase/firestore_service.dart';
import 'package:anmaya/widgets/static/course_card.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),
      drawer: const Sidebar(),
      body: StreamBuilder(
        stream: FirestoreService().coursesCollection().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No courses found.'));
          }
          final courses = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Change as needed
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final data = courses[index].data() as Map<String, dynamic>;
              final instructor = data['instructor'] as Map<String, dynamic>?;
              return CourseCard(
                title: data['title'] ?? '',
                thumbnailUrl: data['thumbnail'] ?? '',
                totalSubscribers: data['totalSubscribers'] ?? 0,
                instructorName:
                    instructor != null ? instructor['name'] ?? '' : '',
                price: double.tryParse(data['price']?.toString() ?? '') ?? 0.0,
                rating:
                    double.tryParse(data['ratings']?.toString() ?? '') ?? 0.0,
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
