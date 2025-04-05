// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

enum CustomTextDirection {
  localeBased,
  ltr,
  rtl,
}

// See http://en.wikipedia.org/wiki/Right-to-left
const List<String> rtlLanguages = <String>[
  'ar', // Arabic
  //'fa', // Farsi
  //'he', // Hebrew
  //'ps', // Pashto
  //'ur', // Urdu
];

// Fake locale to represent the system Locale option.
const systemLocaleOption = Locale('system');

Locale? _deviceLocale;
Locale? get deviceLocale => _deviceLocale;
set deviceLocale(Locale? locale) {
  _deviceLocale ??= locale;
}

class GalleryOptions {
  const GalleryOptions({
    required this.themeMode,
    required double textScaleFactor,
    required this.customTextDirection,
    required Locale locale,
    required this.platform,
  })  : _textScaleFactor = textScaleFactor,
        _locale = locale;

  final ThemeMode themeMode;
  final double _textScaleFactor;
  final CustomTextDirection customTextDirection;
  final Locale _locale;
  final TargetPlatform platform;

  // We use a sentinel value to indicate the system text scale option. By
  // default, return the actual text scale factor, otherwise return the
  // sentinel value.
  double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
    if (_textScaleFactor == systemTextScaleFactorOption) {
      return useSentinel
          ? systemTextScaleFactorOption
          : MediaQuery.of(context).textScaleFactor;
    } else {
      return _textScaleFactor;
    }
  }

  Locale? get locale =>
      _locale;

  /// Returns the text direction based on the [CustomTextDirection] setting.
  /// If the locale cannot be determined, returns null.
  TextDirection? textDirection() {
    switch (customTextDirection) {
      case CustomTextDirection.localeBased:
        final language = locale?.languageCode.toLowerCase();
        if (language == null) return null;
        return rtlLanguages.contains(language)
            ? TextDirection.rtl
            : TextDirection.ltr;
      case CustomTextDirection.rtl:
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  GalleryOptions copyWith({
    required ThemeMode themeMode,
    required double textScaleFactor,
    required CustomTextDirection customTextDirection,
    required Locale locale,
    required double timeDilation,
    required TargetPlatform platform,
  }) {
    return GalleryOptions(
      themeMode: themeMode,
      textScaleFactor: textScaleFactor,
      locale: locale,
      platform: platform, customTextDirection: customTextDirection,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is GalleryOptions &&
      themeMode == other.themeMode &&
      _textScaleFactor == other._textScaleFactor &&
      //customTextDirection == other.customTextDirection &&
      locale == other.locale &&
      platform == other.platform;

  @override
  int get hashCode => Object.hash(
        themeMode,
        _textScaleFactor,
        locale,
        platform,
      );

  static GalleryOptions? of(BuildContext context) {
    final _ModelBindingScope? scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    return scope?.modelBindingState.currentModel;
  }

  static void update(BuildContext context, GalleryOptions newModel) {
    final _ModelBindingScope? scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    scope?.modelBindingState.updateModel(newModel);
  }

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('af'),
    Locale('am'),
    Locale('ar'),
    Locale('ar', 'EG'),
    Locale('ar', 'JO'),
    Locale('ar', 'MA'),
    Locale('ar', 'SA'),
    Locale('as'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('bs'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('de', 'AT'),
    Locale('de', 'CH'),
    Locale('el'),
    Locale('en', 'AU'),
    Locale('en', 'CA'),
    Locale('en', 'GB'),
    Locale('en', 'IE'),
    Locale('en', 'IN'),
    Locale('en', 'NZ'),
    Locale('en', 'SG'),
    Locale('en', 'ZA'),
    Locale('es'),
    Locale('es', '419'),
    Locale('es', 'AR'),
    Locale('es', 'BO'),
    Locale('es', 'CL'),
    Locale('es', 'CO'),
    Locale('es', 'CR'),
    Locale('es', 'DO'),
    Locale('es', 'EC'),
    Locale('es', 'GT'),
    Locale('es', 'HN'),
    Locale('es', 'MX'),
    Locale('es', 'NI'),
    Locale('es', 'PA'),
    Locale('es', 'PE'),
    Locale('es', 'PR'),
    Locale('es', 'PY'),
    Locale('es', 'SV'),
    Locale('es', 'US'),
    Locale('es', 'UY'),
    Locale('es', 'VE'),
    Locale('et'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fil'),
    Locale('fr'),
    Locale('fr', 'CA'),
    Locale('fr', 'CH'),
    Locale('gl'),
    Locale('gsw'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('ka'),
    Locale('kk'),
    Locale('km'),
    Locale('kn'),
    Locale('ko'),
    Locale('ky'),
    Locale('lo'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('ml'),
    Locale('mn'),
    Locale('mr'),
    Locale('ms'),
    Locale('my'),
    Locale('nb'),
    Locale('ne'),
    Locale('nl'),
    Locale('or'),
    Locale('pa'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('pt', 'PT'),
    Locale('ro'),
    Locale('ru'),
    Locale('si'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
    Locale('sv'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('uz'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('zh', 'TW'),
    Locale('zu')
  ];
}

// Everything below is boilerplate except code relating to time dilation.
// See https://medium.com/flutter/managing-flutter-application-state-with-inheritedwidgets-1140452befe1

class _ModelBindingScope extends InheritedWidget {
  const _ModelBindingScope({
    required Key super.key,
    required this.modelBindingState,
    required super.child,
  });

  final _ModelBindingState modelBindingState;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  const ModelBinding({
    required Key key,
    required this.initialModel,
    required this.child,
  })  : super(key: key);

  final GalleryOptions initialModel;
  final Widget child;

  @override
  _ModelBindingState createState() => _ModelBindingState();
}

// Applies text GalleryOptions to a widget
class ApplyTextOptions extends StatelessWidget {
  const ApplyTextOptions({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final options = GalleryOptions.of(context);
    final textScaleFactor = options?.textScaleFactor(context);

    Widget widget = MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(textScaleFactor!),
      ),
      child: child,
    );
    return  widget;
  }
}

class _ModelBindingState extends State<ModelBinding> {
  late GalleryOptions currentModel;
  late Timer? _timeDilationTimer;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  void updateModel(GalleryOptions newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(
      key: widget.key!,
      modelBindingState: this,
      child: widget.child,
    );
  }
}
