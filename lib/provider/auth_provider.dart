import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anmaya/api/custom_http.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // User state variables
  Map<String, dynamic>? user = null;
  String status = "idle";
  String? error = null;
  String? role = null;
  String? message = null;
  bool loading = false;

  // Getters
  bool get isAuthenticated => user != null;
  
  // Login function converted from the Redux thunk action
  Future<bool> login({required String email, required String password}) async {
    try {
      // Set loading state
      loading = true;
      status = "loading";
      error = null;
      notifyListeners();
      
      // Sign in with email and password
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Get Firebase ID token
      final firebaseToken = await userCredential.user!.getIdToken();
      
      // Check if user document exists in Firestore
      final userRef = _firestore.doc('users/${userCredential.user!.uid}');
      final userDoc = await userRef.get();
      
      if (!userDoc.exists) {
        throw Exception('User does not exist.');
      }
      
      // Fetch enrolled courses from subcollection
      final enrolledCoursesRef = _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .collection('enrolledCourses');
          
      final enrolledCoursesSnapshot = await enrolledCoursesRef.get();
      final enrolledCourses = enrolledCoursesSnapshot.docs
          .map((doc) => doc.data()['courseId'] as String)
          .toList();
      
      // Make API call with Firebase token
      final response = await CustomHttp.post(
        '/auth/login',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $firebaseToken',
        },
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to authenticate with API: ${response.body}');
      }
      
      // Set user data
      user = {
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'userData': userDoc.data(),
        'enrolledCourses': enrolledCourses,
      };

      // Extract role if present in userData
      role = (userDoc.data()?['role'] as String?) ?? 'student';
      
      // Update state
      loading = false;
      status = "succeeded";
      message = "Login successful";
      notifyListeners();
      return true;
      
    } catch (error) {
      // Update error state
      loading = false;
      status = "failed";
      this.error = error.toString();
      message = "Login failed";
      notifyListeners();
      return false;
    }
  }

  // Example global function
  Future<void> sendPasswordResetEmail(String email) async {
    loading = true;
    notifyListeners();
    
    try {
      await _auth.sendPasswordResetEmail(email: email);
      message = "Password reset email sent";
      status = "succeeded";
    } catch (e) {
      error = e.toString();
      status = "failed";
      message = "Failed to send password reset email";
    } finally {
      loading = false;
      notifyListeners();
    }
  }
  
  // Logout function
  Future<void> logout() async {
    loading = true;
    status = "loading";
    notifyListeners();
    
    try {
      await _auth.signOut();
      user = null;
      role = null;
      status = "idle";
      message = "Logged out successfully";
    } catch (e) {
      error = e.toString();
      status = "failed";
      message = "Failed to log out";
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // Reset state
  void resetState() {
    status = "idle";
    error = null;
    message = null;
    notifyListeners();
  }

  // Add more global functions as needed...
}
