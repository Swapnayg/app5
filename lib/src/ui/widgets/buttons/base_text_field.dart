// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatelessWidget {
  final Widget suffix;
  final String labelText;
  final String hintText;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String initialValue;

  const BaseTextField({super.key, 
    required this.suffix,
    required this.labelText,
    required this.hintText,
    required this.inputFormatters,
    required this.onSaved,
    required this.validator,
    required this.controller,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      validator: validator,
      maxLines: 1,
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 12.0),
          child: suffix,
        ),
        errorStyle: const TextStyle(fontSize: 12.0),
        errorMaxLines: 3,
        isDense: true,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1.0)),
        hintText: hintText,
      ),
    );
  }
}
