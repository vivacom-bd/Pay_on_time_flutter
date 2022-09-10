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
    apiKey: 'AIzaSyCXh46XAOKCaKdFyTIUQttZCn4nIeDMWSE',
    appId: '1:613268287847:web:b8f1d7e81e1db2b35e7fc2',
    messagingSenderId: '613268287847',
    projectId: 'hidmona-app',
    authDomain: 'hidmona-app.firebaseapp.com',
    storageBucket: 'hidmona-app.appspot.com',
    measurementId: 'G-Y1ZHRQTKS6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGcsskZb8toOdvxtDylf8owRdvg9g499c',
    appId: '1:613268287847:android:c5bcb71f2dd961ab5e7fc2',
    messagingSenderId: '613268287847',
    projectId: 'hidmona-app',
    storageBucket: 'hidmona-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAd43N_LFRkHjZbd46iBXRcg8DDDwvZNYY',
    appId: '1:613268287847:ios:00f7275e050bf0125e7fc2',
    messagingSenderId: '613268287847',
    projectId: 'hidmona-app',
    storageBucket: 'hidmona-app.appspot.com',
    iosClientId: '613268287847-jda1gk8jei867nl73fp8ealjn4pgqv3h.apps.googleusercontent.com',
    iosBundleId: 'ch.hidmona.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAd43N_LFRkHjZbd46iBXRcg8DDDwvZNYY',
    appId: '1:613268287847:ios:57699256e5d6eff35e7fc2',
    messagingSenderId: '613268287847',
    projectId: 'hidmona-app',
    storageBucket: 'hidmona-app.appspot.com',
    iosClientId: '613268287847-32f8p9dh5q66g1dpmep5ltb788s97c0j.apps.googleusercontent.com',
    iosBundleId: 'com.mahmud.hidmona.hidmona',
  );
}