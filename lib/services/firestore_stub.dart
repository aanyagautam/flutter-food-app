// Stub file for Firestore on web builds
// This file provides empty implementations when building for web

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
  Query where(String field, {Object? isEqualTo}) => this;
  Query orderBy(String field, {bool descending = false}) => this;
  Stream<QuerySnapshot> snapshots() => const Stream.empty();
}

class QuerySnapshot {
  List<QueryDocumentSnapshot> get docs => [];
}

class QueryDocumentSnapshot {
  Map<String, dynamic> data() => {};
}

