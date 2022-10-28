import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './home_screen.dart';
// import './widgets/quiz.dart';
// import './widgets/result.dart';

void main() async => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode? themeMode;

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
  }

  @override
  Widget build(BuildContext context) {
    print(themeMode);
    return MaterialApp(
      title: 'Quizzes and Tests',
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
