import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/auth/splash_screen.dart';
import 'utils/constants.dart';

// Conditionally import Firebase only on non-web platforms
import 'package:firebase_core/firebase_core.dart' if (dart.library.html) 'package:flutter_food_app/main_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase on mobile platforms
  if (!kIsWeb) {
    bool firebaseInitialized = false;
    
    try {
      // Initialize Firebase
      // Note: If firebase_options.dart exists (after running flutterfire configure),
      // you should uncomment the options parameter below
      await Firebase.initializeApp(
        // Uncomment the line below after running: flutterfire configure
        // options: DefaultFirebaseOptions.currentPlatform,
      );
      
      // Verify Firebase is initialized
      final apps = Firebase.apps;
      if (apps.isEmpty) {
        throw Exception('Firebase apps list is empty after initialization');
      }
      
      firebaseInitialized = true;
      debugPrint('✅ Firebase initialized successfully');
      debugPrint('✅ ${apps.length} Firebase app(s) ready');
      
    } catch (e) {
      debugPrint('');
      debugPrint('❌ ============================================');
      debugPrint('❌ Firebase Initialization Failed');
      debugPrint('❌ Error: $e');
      debugPrint('❌ ============================================');
      debugPrint('');
      debugPrint('📱 TO FIX THIS ERROR ON MOBILE:');
      debugPrint('');
      debugPrint('   Step 1: Install FlutterFire CLI');
      debugPrint('      dart pub global activate flutterfire_cli');
      debugPrint('');
      debugPrint('   Step 2: Login to Firebase');
      debugPrint('      firebase login');
      debugPrint('');
      debugPrint('   Step 3: Configure Firebase');
      debugPrint('      flutterfire configure');
      debugPrint('');
      debugPrint('   Step 4: Select your Firebase project');
      debugPrint('   Step 5: Select Android and/or iOS platforms');
      debugPrint('   Step 6: This generates firebase_options.dart');
      debugPrint('');
      debugPrint('   Step 7: In lib/main.dart, uncomment this line:');
      debugPrint('      options: DefaultFirebaseOptions.currentPlatform,');
      debugPrint('');
      debugPrint('   Step 8: Restart the app');
      debugPrint('');
      debugPrint('💡 The app will continue, but registration/login');
      debugPrint('   features will not work until Firebase is configured.');
      debugPrint('');
      firebaseInitialized = false;
    }
    
    if (!firebaseInitialized) {
      debugPrint('⚠️ Running without Firebase - using fallback mode');
    }
  } else {
    debugPrint('🌐 Running on web - Using demo mode (Firebase disabled)');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'SchoolFood',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            error: AppColors.error,
            background: AppColors.background,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.textPrimary),
            titleTextStyle: GoogleFonts.poppins(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          cardTheme: CardThemeData(
            elevation: AppStyles.cardElevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStyles.borderRadius),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyles.borderRadius),
              ),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

