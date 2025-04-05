import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.isLoading,
    required this.text,
  });

  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return isLoading ? SizedBox(
      width: 20.0,
      height: 20.0,
      child: Theme(
          data: Theme.of(context)
              .copyWith(hintColor: Theme.of(context).buttonTheme.colorScheme?.onPrimary),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          )),
    ) : Text(text);
  }
}