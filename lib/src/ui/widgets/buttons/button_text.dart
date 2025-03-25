import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key key,
    @required this.isLoading,
    @required this.text,
  }) : super(key: key);

  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return isLoading ? SizedBox(
      width: 20.0,
      height: 20.0,
      child: Theme(
          data: Theme.of(context)
              .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Theme.of(context).buttonTheme.colorScheme.onPrimary)),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          )),
    ) : Text(text);
  }
}