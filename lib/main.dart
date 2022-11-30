// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './screens/home_screen.dart';
// import './widgets/result.dart';

//  void initFirebase() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     await loadBundle();
//     print('Firebase Initialized');
//   }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => print('Firebase Initialized'));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode? themeMode;

  Future<void> loadBundle() async {
    print('Loading Data Bundle');
    ByteData bytes = await rootBundle.load("assets/dataBundle.txt");
    Uint8List buffer =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    FirebaseFirestore.instance.loadBundle(buffer).stream.last;
    print('Data Bundle loaded');
  }

  Future<void> _setThemeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final darkTheme = prefs.getBool('darkTheme');
    setState(() {
      if (darkTheme == null) {
        themeMode = ThemeMode.system;
      } else if (darkTheme == true) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
    });
  }

  void changeTheme(ThemeMode? newThemeMode) async {
    setState(() {
      themeMode = newThemeMode;
    });
    final prefs = await SharedPreferences.getInstance();
    if (newThemeMode == ThemeMode.system) {
      await prefs.remove('darkTheme');
    } else if (newThemeMode == ThemeMode.dark) {
      await prefs.setBool('darkTheme', true);
    } else {
      await prefs.setBool('darkTheme', false);
    }
  }

  @override
  void initState() {
    super.initState();
    _setThemeFromSharedPref();
    loadBundle();
  }

  @override
  Widget build(BuildContext context) {
    print(themeMode);
    return Platform.isIOS
        ?
        // IOS
        CupertinoApp(
            title: 'Quizzin',
            theme: CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.purple,
              primaryContrastingColor: Colors.amber,
            ),
            home: HomeScreen(),
          )
        :
        // ANDROID
        MaterialApp(
            title: 'Quizzin',
            theme: ThemeData(
              brightness: Brightness.light,
              // LIGHT
              colorScheme: ColorScheme.light(
                primary: Colors.purple,
                secondary: Colors.amber,
              ),
              fontFamily: 'Quicksand',
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              // DARK
              colorScheme: ColorScheme.dark(
                primary: Colors.purple,
                secondary: Colors.amber,
              ),
              fontFamily: 'Quicksand',
            ),
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          );
  }
}
