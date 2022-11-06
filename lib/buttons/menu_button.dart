import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {

  final String buttonName;
  final VoidCallback navigationFunction;

  MenuButton(this.buttonName, this.navigationFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
                        child: ElevatedButton(
                          onPressed: navigationFunction,
                          child: Text(buttonName),
                        ),
                      );
  }
}