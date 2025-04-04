// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import './../../../models/app_state_model.dart';
import 'button_text.dart';

class AccentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;
  AppStateModel appStateModel = AppStateModel();

  AccentButton({super.key, 
    required this.onPressed,
    required this.text,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    if (appStateModel.blocks.widgets.button == 'button7') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: onPressed,
          child: ButtonText(isLoading: showProgress, text: text,),
        ),
      );
    } else if (appStateModel.blocks.widgets.button == 'button1') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: ButtonText(isLoading: showProgress, text: text,),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: ButtonText(isLoading: showProgress, text: text,),
        ),
      );
    }
  }
}
