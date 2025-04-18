// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: library_private_types_in_public_api, unused_element_parameter

import 'dart:collection';

import 'package:flutter/material.dart';


// Common constants between SlowMotionSetting and SettingsListItem.
final settingItemBorderRadius = BorderRadius.circular(10);
const settingItemHeaderMargin = EdgeInsetsDirectional.fromSTEB(32, 0, 32, 8);

class DisplayOption {
  final String title;
  final String subtitle;

  DisplayOption(this.title, {required this.subtitle});
}

class SettingsListItem<T> extends StatefulWidget {
  const SettingsListItem({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionChanged,
    required this.onTapSetting,
    required this.isExpanded,
  });

  final String title;
  final LinkedHashMap<T, DisplayOption> options;
  final T selectedOption;
  final ValueChanged<T> onOptionChanged;
  final Function onTapSetting;
  final bool isExpanded;

  @override
  _SettingsListItemState createState() => _SettingsListItemState<T>();
}

class _SettingsListItemState<T> extends State<SettingsListItem<T>>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static const _expandDuration = Duration(milliseconds: 150);
  late AnimationController _controller;
  late Animation<double> _childrenHeightFactor;
  late Animation<double> _headerChevronRotation;
  late Animation<double> _headerSubtitleHeight;
  late Animation<EdgeInsetsGeometry> _headerMargin;
  late Animation<EdgeInsetsGeometry> _headerPadding;
  late Animation<EdgeInsetsGeometry> _childrenPadding;
  late Animation<BorderRadius> _headerBorderRadius;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _expandDuration, vsync: this);
    _childrenHeightFactor = _controller.drive(_easeInTween);
    _headerChevronRotation =
        Tween<double>(begin: 0, end: 0.5).animate(_controller);
    _headerMargin = EdgeInsetsGeometryTween(
      begin: settingItemHeaderMargin,
      end: EdgeInsets.zero,
    ).animate(_controller);
    _headerPadding = EdgeInsetsGeometryTween(
      begin: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 10),
      end: EdgeInsetsDirectional.fromSTEB(32, 18, 32, 20),
    ).animate(_controller);
    _headerSubtitleHeight =
        _controller.drive(Tween<double>(begin: 1.0, end: 0.0));
    _childrenPadding = EdgeInsetsGeometryTween(
      begin: EdgeInsets.symmetric(horizontal: 32),
      end: EdgeInsets.zero,
    ).animate(_controller);
    _headerBorderRadius = BorderRadiusTween(
      begin: settingItemBorderRadius,
      end: BorderRadius.zero,
    ).animate(_controller) as Animation<BorderRadius>;

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleExpansion() {
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse().then<void>((value) {
        if (!mounted) {
          return;
        }
      });
    }
  }

  Widget _buildHeaderWithChildren(BuildContext context, Widget? child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CategoryHeader(
          margin: _headerMargin.value,
          padding: _headerPadding.value,
          borderRadius: _headerBorderRadius.value,
          subtitleHeight: _headerSubtitleHeight,
          chevronRotation: _headerChevronRotation,
          title: widget.title,
          subtitle: widget.options[widget.selectedOption]!.title,
          onTap: () => widget.onTapSetting(),
        ),
        Padding(
          padding: _childrenPadding.value,
          child: ClipRect(
            child: Align(
              heightFactor: _childrenHeightFactor.value,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _handleExpansion();
    final theme = Theme.of(context);

    final optionWidgetsList = <Widget>[];

    widget.options.forEach(
      (optionValue, optionDisplay) => optionWidgetsList.add(
        RadioListTile<T>(
          value: optionValue,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                optionDisplay.title,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                optionDisplay.subtitle,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.8),
                ),
              ),
            ],
          ),
          groupValue: widget.selectedOption,
          onChanged: (newOption) => widget.onOptionChanged(newOption!),
          activeColor: Theme.of(context).colorScheme.primary,
          dense: true,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildHeaderWithChildren,
      child: Container(
        margin: const EdgeInsetsDirectional.only(start: 24, bottom: 40),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => optionWidgetsList[index],
          itemCount: optionWidgetsList.length,
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({
    super.key,
    required this.margin,
    required this.padding,
    required this.borderRadius,
    required this.subtitleHeight,
    required this.chevronRotation,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final String title;
  final String subtitle;
  final Animation<double> subtitleHeight;
  final Animation<double> chevronRotation;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: margin,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),

        //color: colorScheme.background,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium!.apply(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: subtitleHeight,
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelSmall!.apply(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 24,
                ),
                child: RotationTransition(
                  turns: chevronRotation,
                  child: Icon(Icons.arrow_drop_down, color: colorScheme.onSurface,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
