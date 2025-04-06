// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../functions.dart';
import '../../../models/category_model.dart';

class CategoryList extends StatefulWidget {
  List<Category> categories;
  final Function onTapCategory;
  CategoryList({super.key, required this.categories, required this.onTapCategory});
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late List<Category> mainCategories;
  late Category selectedCategory;

  @override
  void initState() {
    super.initState();
    mainCategories = widget.categories.where((cat) => cat.parent == 0).toList();
    if(mainCategories.length != 0) {
      selectedCategory = mainCategories[0];
    }
  }

  void onCategoryClick(Category category) {
    setState(() {
      selectedCategory = category;
    });
    widget.onTapCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mainCategories.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return _buildTiles(mainCategories[index]);
        });
  }

  Widget _buildTiles(Category category) {
    int index = widget.categories.indexOf(category);
    List<Category> subCategories = [];
    if(index != -1) {
      subCategories = widget.categories.where((item) => item.parent == widget.categories[index].id).toList();
    }
    if (subCategories.isEmpty) {
      return _buildTile(category);
    } else {
      return ExpansionTile2(
        key: PageStorageKey<Category>(category),
        leading: leadingIcon(category),
        title: Text(parseHtmlString(category.name)),
        subtitle: Text('Subtitle for ${category.name}'), // Provide a subtitle
        backgroundColor: Colors.grey[200]!, // Provide a background color
        onExpansionChanged: (bool expanded) {
          // Handle expansion state change
          print('${category.name} is ${expanded ? 'expanded' : 'collapsed'}');
        },
        trailing: Icon(Icons.arrow_drop_down), // Provide a trailing widget
        children: subCategories.map(_buildTiles).toList(),
      );
    }
  }

  Widget _buildTile(Category category) {
    return Padding(
      padding: category.parent != 0 ? EdgeInsets.symmetric(horizontal: 8.0) : EdgeInsets.all(0.0),
      child: ListTile(
        //trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          onCategoryClick(category);
        },
        leading: leadingIcon(category),
        title: Text(parseHtmlString(category.name)),
      ),
    );
  }

  SizedBox leadingIcon(Category category) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CachedNetworkImage(
        imageUrl: category.image,
        imageBuilder: (context, imageProvider) => Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.0,
          shape: StadiumBorder(),
          child: Ink.image(
            image: imageProvider,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                onCategoryClick(category);
              },
            ),
          ),
        ),
        placeholder: (context, url) => Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.0,
          shape: StadiumBorder(),
        ),
        errorWidget: (context, url, error) => Card(
          elevation: 0.0,
          color: Colors.white,
          shape: StadiumBorder(),
        ),
      ),
    );
  }
}


const Duration _kExpand = Duration(milliseconds: 200);

/// A single-line [ListTile] with a trailing button that expands or collapses
/// the tile to reveal or hide the [children].
///
/// This widget is typically used with [ListView] to create an
/// "expand / collapse" list entry. When used with scrolling widgets like
/// [ListView], a unique [PageStorageKey] must be specified to enable the
/// [ExpansionTile2] to save and restore its expanded state when it is scrolled
/// in and out of view.
///
/// See also:
///
///  * [ListTile], useful for creating expansion tile [children] when the
///    expansion tile represents a sublist.
///  * The "Expand/collapse" section of
///    <https://material.io/guidelines/components/lists-controls.html>.
class ExpansionTile2 extends StatefulWidget {
  /// Creates a single-line [ListTile] with a trailing button that expands or collapses
  /// the tile to reveal or hide the [children]. The [initiallyExpanded] property must
  /// be non-null.
  const ExpansionTile2({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.onExpansionChanged,
    this.children = const <Widget>[],
    required this.trailing,
    this.initiallyExpanded = false,
  });

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  final Widget leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget subtitle;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool> onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color backgroundColor;

  /// A widget to display instead of a rotating arrow icon.
  final Widget trailing;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  @override
  _ExpansionTile2State createState() => _ExpansionTile2State();
}

class _ExpansionTile2State extends State<ExpansionTile2> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween = CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color> _borderColor;
  late Animation<Color> _headerColor;
  late Animation<Color> _iconColor;
  late Animation<Color> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween) as Animatable<Color>);
    _headerColor =_controller.drive(_headerColorTween.chain(_easeInTween) as Animatable<Color>);
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween) as Animatable<Color>);
    _backgroundColor = _controller.drive(_backgroundColorTween.chain(_easeOutTween) as Animatable<Color>);

    _isExpanded = PageStorage.of(context).readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
    widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor = _borderColor.value;

    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor.value,
        border: Border(
          top: BorderSide(color: borderSideColor),
          bottom: BorderSide(color: borderSideColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTileTheme.merge(
            iconColor: _iconColor.value,
            textColor: _headerColor.value,
            child: ListTile(
              onTap: _handleTap,
              leading: widget.leading,
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: _isExpanded ? RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.remove),
              ) : RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.add),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween
      .end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.titleMedium!.color
      ..end = theme.colorScheme.secondary;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColorTween
      .end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) => _buildChildren(context, child),
      child: closed ? null : Column(children: widget.children),
    );

  }
}