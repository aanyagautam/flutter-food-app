// Stub file for web builds to avoid Firebase compilation errors
// This file provides empty implementations when building for web

class FirebaseAuth {
  static FirebaseAuth get instance => FirebaseAuth();
  User? get currentUser => null;
  Stream<User?> authStateChanges() => const Stream.empty();
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError('Firebase not available on web');
  }
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError('Firebase not available on web');
  }
  Future<void> signOut() async {}
  Future<void> sendPasswordResetEmail({required String email}) {
    throw UnimplementedError('Firebase not available on web');
  }
}

class User {
  String get uid => '';
}

class UserCredential {
  User? get user => null;
}

class FirebaseAuthException implements Exception {
  final String code;
  final String? message;
  FirebaseAuthException(this.code, [this.message]);
}

class FirebaseFirestore {
  static FirebaseFirestore get instance => FirebaseFirestore();
  CollectionReference collection(String path) => CollectionReference();
}

class CollectionReference {
  DocumentReference doc([String? path]) => DocumentReference();
  Query where(String field, {Object? isEqualTo}) => Query();
  Query orderBy(String field, {bool descending = false}) => Query();
  Stream<QuerySnapshot> snapshots() => const Stream.empty();
}

class DocumentReference {
  String get id => '';
  Future<void> set(Map<String, dynamic> data) async {}
  Future<DocumentSnapshot> get() async => DocumentSnapshot();
}

class DocumentSnapshot {
  bool get exists => false;
  Map<String, dynamic>? data() => null;
}

class Query {
  Stream<QuerySnapshot> snapshots() => const Stream.empty();
}

class QuerySnapshot {
  List<QueryDocumentSnapshot> get docs => [];
}

class QueryDocumentSnapshot {
  Map<String, dynamic> data() => {};
}

