import 'package:flutter/material.dart';

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({required Key key, required this.child}) : super(key: key);

  //final color = Theme.of(context).accentColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;//Theme.of(context).accentColor;
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: color),
      child: child,
    );
  }
}