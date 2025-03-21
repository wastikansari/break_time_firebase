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
    apiKey: 'AIzaSyA00usKnWcatxYoad5WomxJnmDLa0HEgbc',
    appId: '1:168678179111:web:c63707c58caf9c15bc2902',
    messagingSenderId: '168678179111',
    projectId: 'break-time-7cd0a',
    authDomain: 'break-time-7cd0a.firebaseapp.com',
    storageBucket: 'break-time-7cd0a.firebasestorage.app',
    measurementId: 'G-45W3BT4YE3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTExihv3NvyIVCwmjJJQ9hI13niVWrqtw',
    appId: '1:168678179111:android:cba94372290bf88fbc2902',
    messagingSenderId: '168678179111',
    projectId: 'break-time-7cd0a',
    storageBucket: 'break-time-7cd0a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYJohg40AoNNMHf8_0_znaVX8j3sNaKxQ',
    appId: '1:168678179111:ios:43625319d8c9630cbc2902',
    messagingSenderId: '168678179111',
    projectId: 'break-time-7cd0a',
    storageBucket: 'break-time-7cd0a.firebasestorage.app',
    iosBundleId: 'com.example.breakTime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYJohg40AoNNMHf8_0_znaVX8j3sNaKxQ',
    appId: '1:168678179111:ios:43625319d8c9630cbc2902',
    messagingSenderId: '168678179111',
    projectId: 'break-time-7cd0a',
    storageBucket: 'break-time-7cd0a.firebasestorage.app',
    iosBundleId: 'com.example.breakTime',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA00usKnWcatxYoad5WomxJnmDLa0HEgbc',
    appId: '1:168678179111:web:9c6848505814e3ccbc2902',
    messagingSenderId: '168678179111',
    projectId: 'break-time-7cd0a',
    authDomain: 'break-time-7cd0a.firebaseapp.com',
    storageBucket: 'break-time-7cd0a.firebasestorage.app',
    measurementId: 'G-P3ZNMNKEVN',
  );
}
