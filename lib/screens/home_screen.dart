import 'package:flutter/material.dart';

import '../widgets/menu_button.dart';
import './catalog_screen.dart';
import './create_screen.dart';
import './settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //
  void pageNavigation(BuildContext ctx, screen) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Text('Quizzes and Tests'),
            Spacer(flex: 1),
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MenuButton(
                    'Catalog',
                    () => pageNavigation(context, CatalogScreen()),
                  ),
                  MenuButton('Saved', () {}),
                  MenuButton(
                    'Create',
                    () => pageNavigation(context, CreateScreen()),
                  ),
                  MenuButton(
                    'Settings',
                    () => pageNavigation(context, SettingsScreen()),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text('My First App'),
      // ),
      // body: _questionIndex < _questions.length
      //     ? Quiz(
      //         answerQuestion: _answerQuestion,
      //         questionIndex: _questionIndex,
      //         questions: _questions,
      //       )
      //     : Result(_totalScore, _resetQuiz),
    );
  }
}
