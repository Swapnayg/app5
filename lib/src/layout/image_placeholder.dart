// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// An image that shows a [placeholder] widget while the target [image] is
/// loading, then fades in the new image when it loads.
///
/// This is similar to [FadeInImage] but the difference is that it allows you
/// to specify a widget as a [placeholder], instead of just an [ImageProvider].
/// It also lets you override the [child] argument, in case you want to wrap
/// the image with another widget, for example an [Ink.image].
class FadeInImagePlaceholder extends StatelessWidget {
  const FadeInImagePlaceholder({
    required Key key,
    required this.image,
    required this.placeholder,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.excludeFromSemantics = false,
    required this.width,
    required this.height,
    required this.fit,
  })  : super(key: key);

  /// The target image that we are loading into memory.
  final ImageProvider image;

  /// Widget displayed while the target [image] is loading.
  final Widget placeholder;

  /// What widget you want to display instead of [placeholder] after [image] is
  /// loaded.
  ///
  /// Defaults to display the [image].
  final Widget child;

  /// The duration for how long the the fade out of the placeholder and
  /// fade in of [child] should take.
  final Duration duration;

  /// See [Image.excludeFromSemantics].
  final bool excludeFromSemantics;

  /// See [Image.width].
  final double width;

  /// See [Image.height].
  final double height;

  /// See [Image.fit].
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        // We only need to animate the loading of images on the web. We can
        // also return early if the images are already in the cache.
        if (wasSynchronouslyLoaded || !kIsWeb) {
          return this.child ?? child;
        } else {
          return AnimatedSwitcher(
            duration: duration,
            child: frame != null ? this.child ?? child : placeholder,
          );
        }
      },
    );
  }
}
