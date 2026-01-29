import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// Demo authentication service for web testing
/// Stores user data locally in SharedPreferences
class DemoAuthService {
  static const String _usersKey = 'demo_users';
  static const String _currentUserKey = 'demo_current_user';

  // In-memory storage for demo
  static final Map<String, SchoolUser> _users = {};

  Future<void> _loadUsers() async {
    if (_users.isNotEmpty) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersList = prefs.getStringList(_usersKey) ?? [];
      
      for (var email in usersList) {
        final userJson = prefs.getString('demo_user_data_$email');
        if (userJson != null) {
          try {
            // Parse user data - simple approach for demo
            final parts = userJson.split('|');
            if (parts.length >= 8) {
              final user = SchoolUser(
                id: parts[0],
                parentName: parts[1],
                phone: parts[2],
                email: parts[3],
                childName: parts[4],
                childClass: parts[5],
                childRollNo: parts[6],
                schoolId: parts[7],
                isTeacher: parts.length > 8 ? parts[8] == 'true' : false,
                createdAt: parts.length > 9 
                    ? DateTime.tryParse(parts[9]) ?? DateTime.now()
                    : DateTime.now(),
              );
              _users[email] = user;
            }
          } catch (e) {
            // Skip invalid user data
          }
        }
      }
    } catch (e) {
      // Ignore errors
    }
  }

  Future<void> _saveUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersList = <String>[];
      
      // Save each user's data
      for (var user in _users.values) {
        usersList.add(user.email);
        final userData = '${user.id}|${user.parentName}|${user.phone}|'
            '${user.email}|${user.childName}|${user.childClass}|'
            '${user.childRollNo}|${user.schoolId}|${user.isTeacher}|'
            '${user.createdAt.toIso8601String()}';
        await prefs.setString('demo_user_data_${user.email}', userData);
      }
      
      await prefs.setStringList(_usersKey, usersList);
    } catch (e) {
      // Ignore errors
    }
  }

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
    await _loadUsers();

    // Check if user already exists
    if (_users.containsKey(email)) {
      throw 'An account already exists for that email.';
    }

    // Validate password
    if (password.length < 6) {
      throw 'Password must be at least 6 characters.';
    }

    // Create user
    final userId = 'demo_${DateTime.now().millisecondsSinceEpoch}';
    final user = SchoolUser(
      id: userId,
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

    _users[email] = user;
    await _saveUsers();
    await _saveCurrentUser(user);

    return user;
  }

  Future<SchoolUser?> login(String email, String password) async {
    await _loadUsers();

    // Load user from storage
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('demo_user_$email');
      
      if (userId != null) {
        // Try to get user from memory
        final user = _users[email];
        if (user != null) {
          await _saveCurrentUser(user);
          return user;
        }
      }
    } catch (e) {
      // Ignore
    }

    // Check in-memory storage
    final user = _users[email];
    if (user != null) {
      await _saveCurrentUser(user);
      return user;
    }

    throw 'No user found for that email.';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<SchoolUser?> getCurrentUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(_currentUserKey);
      if (email != null) {
        await _loadUsers();
        return _users[email];
      }
    } catch (e) {
      // Ignore errors
    }
    return null;
  }

  Future<void> _saveCurrentUser(SchoolUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, user.email);
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_email', user.email);
  }

  Future<void> resetPassword(String email) async {
    // Demo mode - just show a message
    throw 'Password reset is not available in demo mode.';
  }

  Stream<SchoolUser?> get authStateChanges async* {
    yield await getCurrentUserData();
  }
}

