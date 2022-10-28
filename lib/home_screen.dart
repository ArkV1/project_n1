import 'package:flutter/material.dart';
import 'package:project_n1/settings_screen.dart';

import './widgets/menu_button.dart';

class HomeScreen extends StatelessWidget {
  void pageNavigation(BuildContext ctx, screen) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            Spacer(flex: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                Text('Quizzes and Tests'),
                Spacer(flex: 1),
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      MenuButton('Catalog', () {}),
                      MenuButton('Saved', () {}),
                      MenuButton('Create', () {}),
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
            Spacer(flex: 1),
          ],
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
