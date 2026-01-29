// Stub file for web builds - prevents Firebase import errors
// This file is imported conditionally when building for web

// Empty stub - Firebase is not used on web
class Firebase {
  static Future<void> initializeApp({dynamic options}) async {
    // No-op for web
  }
  
  static List<FirebaseApp> get apps => [];
}

class FirebaseApp {
  // Stub class
}

// Stub for firebase_options on web
class DefaultFirebaseOptions {
  static dynamic get currentPlatform => null;
}










