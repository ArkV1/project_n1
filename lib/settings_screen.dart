import 'package:flutter/material.dart';

import './main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Spacer(flex: 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          MyApp.of(context).changeTheme(ThemeMode.system),
                      child: Text('System Default'),
                    ),
                    ElevatedButton(
                      onPressed:
                          null, // () => MyApp.of(context).changeTheme(ThemeMode.dark, 'OLED'),
                      child: Text('Black (OLED)'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          MyApp.of(context).changeTheme(ThemeMode.dark),
                      child: Text('Dark'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          MyApp.of(context).changeTheme(ThemeMode.light),
                      child: Text('Light'),
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
    );
  }
}
