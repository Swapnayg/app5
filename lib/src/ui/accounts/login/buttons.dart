// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class WhiteButton extends _BaseButton {
  final bool flat;
  @override
  // ignore: overridden_fields

  final bool bold;

  WhiteButton({
    required super.onPressed,
    required super.text,
    required super.child,
    this.flat = false,
    this.bold = true,
    required IconData iconData,
  }) : super(
          showProgress: false,
          iconData: iconData,
          borderRadius: BorderRadius.circular(0),
          textStyle: TextStyle(
              fontSize: 14.0,
              color: Colors.black87.withOpacity(0.8),
              fontWeight: bold ? FontWeight.bold : FontWeight.normal),
          color: Colors.white,
          borderSide: flat
              ? BorderSide.none
              : const BorderSide(color: Colors.grey, width: 0.5),
        );
}

class AccentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;

  const AccentButton({super.key, 
    required this.onPressed,
    required this.text,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseButton(
      onPressed: onPressed,
      showProgress: showProgress,
      color: Theme.of(context).colorScheme.primary,
      borderSide: BorderSide.none,
      borderRadius: const BorderRadius.all(Radius.circular(0.0)),
      textStyle: TextStyle(
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.bold),
      text: text.toUpperCase(), iconData: null, child: const SizedBox.shrink(),
    );
  }
}

class AccountButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;
  final BorderRadius borderRadius;

  const AccountButton({super.key, 
    required this.onPressed,
    required this.text,
    this.showProgress = false,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseButton(
      onPressed: onPressed,
      showProgress: showProgress,
      color: Theme.of(context).colorScheme.primary,
      borderSide: BorderSide.none,
      borderRadius: borderRadius,
      textStyle: TextStyle(
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.bold),
      text: text.toUpperCase(),iconData: null, child: const SizedBox.shrink(),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;

  const AddToCartButton({super.key, 
    required this.onPressed,
    required this.text,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseButton(
      onPressed: onPressed,
      showProgress: showProgress,
      color: Theme.of(context).colorScheme.primary,
      borderSide: BorderSide.none,
      borderRadius: const BorderRadius.all(Radius.circular(0.0)),
      textStyle: TextStyle(
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.bold),
      text: text.toUpperCase(),iconData: null, child: const SizedBox.shrink(),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;

  const PrimaryButton({super.key, 
    required this.onPressed,
    required this.text,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseButton(
      onPressed: onPressed,
      showProgress: showProgress,
      color: Theme.of(context).primaryColor,
      borderSide: BorderSide.none,
      borderRadius: const BorderRadius.all(Radius.circular(0.0)),
      textStyle: TextStyle(
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold),
      text: text,iconData: null, child: const SizedBox.shrink(),
    );
  }
}

class BlackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;
  final IconData? iconData;

  const BlackButton(
      {super.key, required this.onPressed,
      required this.text,
      this.showProgress = false,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return _BaseButton(
      onPressed: onPressed,
      showProgress: showProgress,
      color: Theme.of(context).colorScheme.brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      borderSide: BorderSide.none,
      borderRadius: const BorderRadius.all(Radius.circular(0.0)),
      textStyle: TextStyle(
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          fontWeight: FontWeight.bold),
      text: text,
      iconData: null, child: const SizedBox.shrink(),
    );
  }
}

class _BaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool showProgress;
  final TextStyle textStyle;
  final Color color;
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final IconData? iconData;
  final Widget child;

  const _BaseButton({
    required this.onPressed,
    required this.showProgress,
    required this.text,
    required this.textStyle,
    required this.color,
    required this.borderSide,
    required this.borderRadius,
    required this.iconData,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    //const borderRadius = const BorderRadius.all(Radius.circular(5.0));
    Text textWidget;
    textWidget = new Text(
      text,
      textAlign: TextAlign.center,
      style: textStyle,
    );
      return Container(
        //width: 300,
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ElevatedButton(
              onPressed: showProgress ? null : onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: borderRadius, side: borderSide), backgroundColor: color,
              ),
              child: showProgress
                  ? SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Theme(
                          data: Theme.of(context)
                              .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: textStyle.color)),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          )),
                    )
                  : iconData == null
                      ? child
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              iconData,
                              color: textStyle.color!.withOpacity(0.5),
                            ),
                            const SizedBox(width: 2.0),
                            textWidget,
                          ],
                        )),
        ));
  }
}
