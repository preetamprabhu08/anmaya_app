import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_core_setup.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseCoreSetup().auth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

}
