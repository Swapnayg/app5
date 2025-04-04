// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [HighlightFocus] is a helper widget for giving a child focus
/// allowing tab-navigation.
/// Wrap your widget as [child] of a [HighlightFocus] widget.
class HighlightFocus extends StatefulWidget {
  const HighlightFocus({super.key, 
    required this.onPressed,
    required this.child,
    required this.highlightColor,
    required this.borderColor,
    this.hasFocus = true,
    required this.debugLabel,
  });

  /// [onPressed] is called when you press space, enter, or numpad-enter
  /// when the widget is focused.
  final VoidCallback onPressed;

  /// [child] is your widget.
  final Widget child;

  /// [highlightColor] is the color filled in the border when the widget
  /// is focused.
  /// Use [Colors.transparent] if you do not want one.
  /// Use an opacity less than 1 to make the underlying widget visible.
  final Color highlightColor;

  /// [borderColor] is the color of the border when the widget is focused.
  final Color borderColor;

  /// [hasFocus] is true when focusing on the widget is allowed.
  /// Set to false if you want the child to skip focus.
  final bool hasFocus;

  final String debugLabel;

  @override
  _HighlightFocusState createState() => _HighlightFocusState();
}

class _HighlightFocusState extends State<HighlightFocus> {
  late bool isFocused;

  @override
  void initState() {
    isFocused = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color _highlightColor = widget.highlightColor;
    Color _borderColor =
        widget.borderColor;

    BoxDecoration _highlightedDecoration = BoxDecoration(
      color: _highlightColor,
      border: Border.all(
        color: _borderColor,
        width: 2,
      ),
    );

    return Focus(
      canRequestFocus: widget.hasFocus,
      debugLabel: widget.debugLabel,
      onFocusChange: (newValue) {
        setState(() {
          isFocused = newValue;
        });
      },
      onKey: (node, event) {
        if (event is RawKeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.space ||
                event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
          widget.onPressed();
          return KeyEventResult.handled;
        } else {
          return KeyEventResult.ignored;
        }
      },
      child: Container(
        foregroundDecoration: isFocused ? _highlightedDecoration : null,
        child: widget.child,
      ),
    );
  }
}
