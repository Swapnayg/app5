// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'layout/adaptive.dart';

/*import 'package:gallery/constants.dart';
import 'package:gallery/layout/adaptive.dart';
import 'package:gallery/pages/home.dart';*/

const homePeekDesktop = 210.0;
const homePeekMobile = 0.0;

class SplashPageAnimation extends InheritedWidget {
  const SplashPageAnimation({
    required Key super.key,
    required this.isFinished,
    required super.child,
  });

  final bool isFinished;

  static SplashPageAnimation? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(SplashPageAnimation oldWidget) => true;
}

class SplashPage extends StatefulWidget {
  const SplashPage({
    required Key key,
    this.isAnimated = true,
    required this.child,
  }) : super(key: key);

  final bool isAnimated;
  final Widget child;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer? _launchTimer;
  late int _effect;
  final _random = Random();

  // A map of the effect index to its duration. This duration is used to
  // determine how long to display the splash animation at launch.
  //
  // If a new effect is added, this map should be updated.
  final _effectDurations = {
    1: 5,
    2: 4,
    3: 4,
    4: 5,
    5: 5,
    6: 4,
    7: 4,
    8: 4,
    9: 3,
    10: 6,
  };

  bool get _isSplashVisible {
    return _controller.status == AnimationStatus.completed ||
        _controller.status == AnimationStatus.forward;
  }

  @override
  void initState() {
    super.initState();

    // If the number of included effects changes, this number should be changed.
    _effect = _random.nextInt(_effectDurations.length) + 1;

    _controller = AnimationController(
        duration: Duration(
          milliseconds: splashPageAnimationDurationInMilliseconds,
        ),
        value: 1,
        vsync: this)
      ..addListener(() {
        setState(() {});
      });
    if (widget.isAnimated) {
      _launchTimer = Timer(
        Duration(seconds: _effectDurations[_effect] ?? 0),
        () {
          _controller.fling(velocity: -1);
        },
      );
    } else {
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _launchTimer?.cancel();
    _launchTimer = null;
    super.dispose();
  }

  Animation<RelativeRect> _getPanelAnimation(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final double height = constraints.biggest.height -
        (isDisplayDesktop(context) ? homePeekDesktop : homePeekMobile);
    return RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: RelativeRect.fromLTRB(0, height, 0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return SplashPageAnimation(
      key: widget.key!,
      isFinished: _controller.status == AnimationStatus.dismissed,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final Animation<RelativeRect> animation =
          _getPanelAnimation(context, constraints);
          Widget frontLayer = widget.child;
          if (_isSplashVisible) {
            frontLayer = GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _controller.reverse();
              },
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy < -200) {
                  _controller.reverse();
                }
              },
              child: IgnorePointer(child: frontLayer),
            );
          }

          if (isDisplayDesktop(context)) {
            frontLayer = Padding(
              padding: const EdgeInsets.only(top: 136),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                child: frontLayer,
              ),
            );
          }

          return Stack(
            children: [
              _SplashBackLayer(
                key: ValueKey('SplashBackLayer'), // Provide a unique key
                isSplashCollapsed: !_isSplashVisible,
                effect: _effect,
                onTap: () {
                  _controller.forward();
                },
              ),
              PositionedTransition(
                rect: animation,
                child: frontLayer,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SplashBackLayer extends StatelessWidget {
  const _SplashBackLayer({
    required Key key,
    required this.isSplashCollapsed,
    required this.effect,
    required this.onTap,
  }) : super(key: key);

  final bool isSplashCollapsed;
  final int effect;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var effectAsset = 'lib/assets/splash_effects/splash_effect_$effect.gif';
    final flutterLogo = Image.asset('lib/assets/logo/flutter_logo.png');

    Widget child;
    if (isSplashCollapsed) {
      child = (isDisplayDesktop(context)
          ? Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: onTap,
                  child: flutterLogo,
                ),
              ),
            )
          : null)!;
    } else {
      child = Stack(
        children: [
          Center(child: Image.asset(effectAsset)),
          Center(child: flutterLogo),
        ],
      );
    }

    return ExcludeSemantics(
      child: Container(
        color: Color(0xFF030303), // This is the background color of the gifs.
        padding: EdgeInsets.only(
          bottom: isDisplayDesktop(context) ? homePeekDesktop : homePeekMobile,
        ),
        child: child,
      ),
    );
  }
}
