import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCoreSetup {
  static final FirebaseCoreSetup _instance = FirebaseCoreSetup._internal();

  factory FirebaseCoreSetup() => _instance;

  FirebaseCoreSetup._internal();

  // No initialize() method here because main.dart already does it.

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
}
