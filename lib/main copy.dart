import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './home_screen.dart';
// import './widgets/quiz.dart';
// import './widgets/result.dart';

Future<ThemeMode> _getThemeFromSharedPref() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final darkTheme = prefs.getBool('darkTheme');
  if (darkTheme == null) {
    return ThemeMode.system;
  } else if (darkTheme == true) {
    ThemeMode.dark;
  }
  return ThemeMode.light;
}

void main() async {
  ThemeMode themeMode = await _getThemeFromSharedPref();
  runApp(MyApp(themeMode));
}

class MyApp extends StatefulWidget {
  ThemeMode themeMode;
  MyApp(this.themeMode);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState(themeMode);
  }
}

class _MyAppState extends State<MyApp> {

  
  ThemeMode themeMode;
  _MyAppState(this.themeMode);

  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    }

    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    print('Answer chosen');
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
      ),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
