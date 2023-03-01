import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AdaptiveOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressedHandler;

  AdaptiveOutlinedButton(this.text, this.onPressedHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: onPressedHandler,
          )
        : OutlinedButton(
            onPressed: onPressedHandler,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
