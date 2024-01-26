// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBaStm92OGMYRcQb_HKxuznsXPKBWkoAPE',
    appId: '1:65479514811:web:694496666b16ce36a0279e',
    messagingSenderId: '65479514811',
    projectId: 'flutter-inventory-312f0',
    authDomain: 'flutter-inventory-312f0.firebaseapp.com',
    storageBucket: 'flutter-inventory-312f0.appspot.com',
    measurementId: 'G-L53HC8Z2WQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3RoEbB8JMFHsOYztQe_FILAAigoi13os',
    appId: '1:65479514811:android:4f184a12300a2302a0279e',
    messagingSenderId: '65479514811',
    projectId: 'flutter-inventory-312f0',
    storageBucket: 'flutter-inventory-312f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKue__nIy0XzF5chRdtzB830zGccIdYzs',
    appId: '1:65479514811:ios:6262836381e19388a0279e',
    messagingSenderId: '65479514811',
    projectId: 'flutter-inventory-312f0',
    storageBucket: 'flutter-inventory-312f0.appspot.com',
    iosBundleId: 'com.example.flutterInventory',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKue__nIy0XzF5chRdtzB830zGccIdYzs',
    appId: '1:65479514811:ios:cfc9ca562dab4f21a0279e',
    messagingSenderId: '65479514811',
    projectId: 'flutter-inventory-312f0',
    storageBucket: 'flutter-inventory-312f0.appspot.com',
    iosBundleId: 'com.example.flutterInventory.RunnerTests',
  );
}