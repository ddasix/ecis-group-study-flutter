// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAU8llDuznXytIbqwFpottgZDni0BxMfRI',
    appId: '1:477983621314:web:41d22206d6c0ca16c9bb5b',
    messagingSenderId: '477983621314',
    projectId: 'calendar-schedule-57822',
    authDomain: 'calendar-schedule-57822.firebaseapp.com',
    storageBucket: 'calendar-schedule-57822.appspot.com',
    measurementId: 'G-QKDLH2TXEN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD93oH808gnXXHvVr7zO0sME_a77_A1Nms',
    appId: '1:477983621314:android:12010402b1cccbf6c9bb5b',
    messagingSenderId: '477983621314',
    projectId: 'calendar-schedule-57822',
    storageBucket: 'calendar-schedule-57822.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCha_lPURmZBtFSNRSebs3iLOQtbLqIqew',
    appId: '1:477983621314:ios:0e2d8dca8f0b2075c9bb5b',
    messagingSenderId: '477983621314',
    projectId: 'calendar-schedule-57822',
    storageBucket: 'calendar-schedule-57822.appspot.com',
    iosBundleId: 'com.example.calendarScheduler',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCha_lPURmZBtFSNRSebs3iLOQtbLqIqew',
    appId: '1:477983621314:ios:0e2d8dca8f0b2075c9bb5b',
    messagingSenderId: '477983621314',
    projectId: 'calendar-schedule-57822',
    storageBucket: 'calendar-schedule-57822.appspot.com',
    iosBundleId: 'com.example.calendarScheduler',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAU8llDuznXytIbqwFpottgZDni0BxMfRI',
    appId: '1:477983621314:web:6a31bb6f872f3137c9bb5b',
    messagingSenderId: '477983621314',
    projectId: 'calendar-schedule-57822',
    authDomain: 'calendar-schedule-57822.firebaseapp.com',
    storageBucket: 'calendar-schedule-57822.appspot.com',
    measurementId: 'G-VWFLVFEZN5',
  );
}
