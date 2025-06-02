import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_core_setup.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseCoreSetup().firestore;

  CollectionReference usersCollection() => _firestore.collection('users');
  CollectionReference coursesCollection() => _firestore.collection('courses');

  
  // Add more methods as needed
}
