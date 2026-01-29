import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'demo_auth_service.dart';

// Conditional Firebase imports - only import on non-web platforms
import 'package:firebase_auth/firebase_auth.dart' if (dart.library.html) 'package:flutter_food_app/services/firebase_stub.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart' if (dart.library.html) 'package:flutter_food_app/services/firebase_stub.dart' as cloud_firestore;

class AuthService {
  firebase_auth.FirebaseAuth get _auth => firebase_auth.FirebaseAuth.instance;
  cloud_firestore.FirebaseFirestore get _firestore => cloud_firestore.FirebaseFirestore.instance;

  // Get current user
  firebase_auth.User? get currentUser => kIsWeb ? null : _auth.currentUser;

  // Auth state stream
  Stream<firebase_auth.User?> get authStateChanges {
    if (kIsWeb) {
      // Use demo mode on web - return a stream that emits current user state
      final demoService = DemoAuthService();
      return Stream.periodic(const Duration(seconds: 1), (_) => null)
          .asyncMap((_) => demoService.getCurrentUserData())
          .map((user) => null); // Convert to User? for compatibility
    }
    return _auth.authStateChanges();
  }

  // Register new user
  Future<SchoolUser?> register({
    required String email,
    required String password,
    required String parentName,
    required String phone,
    required String childName,
    required String childClass,
    required String childRollNo,
    required String schoolId,
    bool isTeacher = false,
  }) async {
    if (kIsWeb) {
      // Use demo mode on web
      final demoService = DemoAuthService();
      return await demoService.register(
        email: email,
        password: password,
        parentName: parentName,
        phone: phone,
        childName: childName,
        childClass: childClass,
        childRollNo: childRollNo,
        schoolId: schoolId,
        isTeacher: isTeacher,
      );
    }
    
    try {
      // Create Firebase Auth user
      firebase_auth.UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Create user document in Firestore
        SchoolUser user = SchoolUser(
          id: credential.user!.uid,
          parentName: parentName,
          phone: phone,
          email: email,
          childName: childName,
          childClass: childClass,
          childRollNo: childRollNo,
          schoolId: schoolId,
          isTeacher: isTeacher,
          createdAt: DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toMap());

        // Save user data locally
        await _saveUserLocally(user);

        return user;
      }
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Registration failed: ${e.toString()}';
    }
  }

  // Login
  Future<SchoolUser?> login(String email, String password) async {
    if (kIsWeb) {
      // Use demo mode on web
      final demoService = DemoAuthService();
      return await demoService.login(email, password);
    }
    
    try {
      firebase_auth.UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Fetch user data from Firestore
        cloud_firestore.DocumentSnapshot doc = await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .get();

        if (doc.exists) {
          SchoolUser user = SchoolUser.fromMap(doc.data() as Map<String, dynamic>);
          await _saveUserLocally(user);
          return user;
        }
      }
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Login failed: ${e.toString()}';
    }
  }

  // Logout
  Future<void> logout() async {
    if (kIsWeb) {
      // Use demo mode on web
      final demoService = DemoAuthService();
      await demoService.logout();
    } else {
      await _auth.signOut();
    }
    await _clearUserLocally();
  }

  // Forgot Password
  Future<void> resetPassword(String email) async {
    if (kIsWeb) {
      throw 'Firebase is not available on web. Please use Android/iOS for full functionality.';
    }
    
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Password reset failed: ${e.toString()}';
    }
  }

  // Get current user data
  Future<SchoolUser?> getCurrentUserData() async {
    if (kIsWeb) {
      // Use demo mode on web
      final demoService = DemoAuthService();
      return await demoService.getCurrentUserData();
    }
    if (currentUser == null) return null;

    try {
      cloud_firestore.DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (doc.exists) {
        return SchoolUser.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Local storage helpers
  Future<void> _saveUserLocally(SchoolUser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_email', user.email);
  }

  Future<void> _clearUserLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_email');
  }

  String _handleAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
