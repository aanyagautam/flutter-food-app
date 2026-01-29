import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  SchoolUser? _user;
  bool _isLoading = false;

  SchoolUser? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    _isLoading = true;
    notifyListeners();

    _authService.authStateChanges.listen((firebaseUser) async {
      // Check for current user regardless of firebaseUser (for demo mode)
      _user = await _authService.getCurrentUserData();
      _isLoading = false;
      notifyListeners();
    });
    
    // Also check immediately for demo mode
    _user = await _authService.getCurrentUserData();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.login(email, password);
      if (_user == null) {
        throw 'Login failed. Please try again.';
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> register({
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
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.register(
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

      if (_user == null) {
        throw 'Registration failed. Please try again.';
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authService.logout();
    _user = null;

    _isLoading = false;
    notifyListeners();
  }
}
