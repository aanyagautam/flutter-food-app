# Flutter Food Ordering App for Students

A Flutter mobile application for students to order food from parents/teachers during school hours. Teachers who are also parents can order for their own children. Features simple authentication with child/parent details collection and **auto-disable ordering on Sundays & school holidays**.

## 🎯 Features

### Authentication
- ✅ Splash Screen (3 seconds)
- ✅ Register Screen (2-step: Parent → Child details)
- ✅ Login Screen (Email/Phone + Password)
- ✅ Forgot Password (basic email reset)

### Main App Flow
- ✅ Home → Food Menu → Add to Cart → Checkout → Order Confirmation
- ✅ Bottom Navigation (Home, Menu, Cart, Profile)

### Food Ordering Features
- ✅ Daily/Weekly Menu Display
- ✅ Add/Remove from Cart
- ✅ Quantity Selection (+/-)
- ✅ Order Summary
- ✅ Payment Status (Cash/Pending)
- ✅ Order History

### School Holiday Logic ⚠️ **CRITICAL**
- ✅ Disable ordering on Sundays
- ✅ Disable ordering on School Holidays (10 major holidays hardcoded)
- ✅ School Closed message with countdown
- ✅ Shows: "School Closed Today - Ordering Disabled"

## 🛠 Tech Stack

- **Framework**: Flutter 3.x (Dart)
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **Backend**: Firebase (Auth + Firestore)
- **Icons**: Material Icons
- **UI**: Material 3 Design
- **Fonts**: Google Fonts (Roboto + Poppins)

## 📂 Project Structure

```
lib/
├── main.dart
├── models/
│   ├── user_model.dart
│   ├── child_model.dart
│   ├── food_item.dart
│   └── order_model.dart
├── screens/
│   ├── auth/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── menu/
│   │   └── menu_screen.dart
│   ├── cart/
│   │   └── cart_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   └── order/
│       ├── order_confirmation_screen.dart
│       └── order_history_screen.dart
├── services/
│   ├── auth_service.dart
│   ├── holiday_service.dart
│   └── order_service.dart
├── providers/
│   ├── auth_provider.dart
│   └── cart_provider.dart
├── widgets/
│   └── food_item_card.dart
└── utils/
    └── constants.dart
```

## 🚀 Setup Instructions

### Prerequisites

1. **Flutter SDK**: Install Flutter 3.x or higher
   ```bash
   flutter --version
   ```

2. **Firebase Account**: Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)

### Installation Steps

1. **Clone or download the project**
   ```bash
   cd flutter_food_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**

   a. **Create Firebase Project**
      - Go to [Firebase Console](https://console.firebase.google.com/)
      - Click "Add Project"
      - Follow the setup wizard

   b. **Enable Authentication**
      - In Firebase Console, go to Authentication
      - Click "Get Started"
      - Enable "Email/Password" sign-in method

   c. **Create Firestore Database**
      - Go to Firestore Database
      - Click "Create Database"
      - Start in "Test Mode" (for development)
      - Choose a location

   d. **Add Firebase to Flutter**
      - Install Firebase CLI: `npm install -g firebase-tools`
      - Install FlutterFire CLI: `dart pub global activate flutterfire_cli`
      - Run: `flutterfire configure`
      - Select your Firebase project
      - Select platforms (Android, iOS, Web)

   e. **Update Firestore Rules** (for production)
      ```javascript
      rules_version = '2';
      service cloud.firestore {
        match /databases/{database}/documents {
          match /users/{userId} {
            allow read, write: if request.auth != null && request.auth.uid == userId;
          }
          match /orders/{orderId} {
            allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
          }
        }
      }
      ```

4. **Configure Assets** (Optional)
   - Create `assets/images/` folder in the root directory
   - Add food item images (dal_rice.jpg, roti_sabzi.jpg, etc.)
   - Images are optional - the app uses icons as placeholders

5. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Building APK

### Android APK

```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

## 🎨 Design Guidelines

- **Color Scheme**:
  - Primary: #4A90E2 (Blue)
  - Secondary: #50C878 (Green)
  - Background: #F8F9FA
  - Error: #E74C3C
  - Success: #27AE60

- **Typography**: Google Fonts (Roboto + Poppins)
- **Card Layout**: Rounded corners (12px), Elevation: 2-4dp
- **Icons**: Material Icons (24dp)

## 📋 School Holidays

The app automatically disables ordering on:
- All Sundays
- 10 major holidays (hardcoded in `lib/services/holiday_service.dart`):
  - Republic Day (Jan 26)
  - Holi (Mar 1)
  - Annual Day (Mar 15)
  - Ambedkar Jayanti (Apr 14)
  - Labour Day (May 1)
  - Independence Day (Aug 15)
  - Gandhi Jayanti (Oct 2)
  - Dussehra (Oct 20)
  - Diwali (Nov 14)
  - Christmas (Dec 25)

To modify holidays, edit `lib/services/holiday_service.dart`.

## 🔥 Firebase Collections Structure

### Users Collection
```json
{
  "id": "user_id",
  "parentName": "John Doe",
  "phone": "+1234567890",
  "email": "john@example.com",
  "childName": "Jane Doe",
  "childClass": "5A",
  "childRollNo": "25",
  "schoolId": "SCH001",
  "isTeacher": false,
  "createdAt": "2026-01-01T00:00:00Z"
}
```

### Orders Collection
```json
{
  "id": "order_id",
  "userId": "user_id",
  "childName": "Jane Doe",
  "childClass": "5A",
  "items": [
    {
      "foodItem": {
        "id": "1",
        "name": "Dal Rice",
        "price": 25.0,
        "image": "assets/images/dal_rice.jpg"
      },
      "quantity": 2
    }
  ],
  "totalAmount": 50.0,
  "paymentStatus": "Pending",
  "orderDate": "2026-01-01T00:00:00Z",
  "status": "Pending"
}
```

## 🧪 Testing

1. **Register a new account** with parent and child details
2. **Login** with registered credentials
3. **Browse menu** and add items to cart
4. **Test holiday blocking** - try ordering on Sunday or a holiday date
5. **Place an order** and view order confirmation
6. **Check order history** in profile section

## 🚫 Features NOT Included

- Complex animations
- Payment gateway integration
- Push notifications
- Admin panel
- Google Maps integration

## 📝 Notes

- The app uses UTC timezone for date calculations
- Menu items are currently loaded from constants (can be replaced with Firestore)
- Food images are optional - app uses icons as placeholders
- For production, update Firestore security rules
- Ensure Firebase is properly configured before running

## 🤝 Support

For issues or questions, please check:
- Flutter documentation: https://flutter.dev/docs
- Firebase documentation: https://firebase.google.com/docs

## 📄 License

This project is created for educational purposes.

---

**Generated by Flutter Food App Generator**

