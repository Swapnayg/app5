// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/app_state_model.dart';
import '../../ui/checkout/cart/cart4.dart';
import '../../ui/home/search.dart';

class SearchBar extends StatefulWidget {
  final bool isVisible;
  const SearchBar({super.key, required this.isVisible});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 110,
        child: AppBar(
          backgroundColor: widget.isVisible ? Colors.amber : Colors.transparent,
          title: buildAppbarSearch(context), systemOverlayStyle: SystemUiOverlayStyle.dark,
        ));
  }
}

Row buildAppbarSearch(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        child: InkWell(
          //onTap: () => _scanBarCode(),
          child: Icon(
            FontAwesomeIcons.camera, // Replaced with a valid icon
            color: Theme.of(context)
                .primaryIconTheme
                .color, //Theme.of(context).primaryIconTheme.color,Theme.of(context).hintColor,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            enableFeedback: false,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Search(filter: {},);
              }));
            },
            child: TextField(
              //showCursor: false,
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Search products',
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(.7),
                  fontSize: 16,
                  fontFamily: 'Circular',
                ),
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).inputDecorationTheme.fillColor
                    : Colors.white,
                filled: true,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                    width: 0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                    width: 0,
                  ),
                ),
                contentPadding: EdgeInsets.all(6),
                prefixIcon: Icon(
                  FontAwesomeIcons.search,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CartPage(),
                fullscreenDialog: true,
              ));
        },
        child: Stack(children: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: Theme.of(context)
                .primaryIconTheme
                .color, //Theme.of(context).hintColor
          ),
          Positioned(
            top: -3.0,
            right: -3.0,
            child: ScopedModelDescendant<AppStateModel>(
                builder: (context, child, model) {
              if (model.count != 0) {
                return Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    shape: StadiumBorder(),
                    color: Colors.red,
                    child: Container(
                        padding: EdgeInsets.all(2),
                        constraints: BoxConstraints(minWidth: 20.0),
                        child: Center(
                            child: Text(
                          model.count.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                        ))));
              } else {
                return Container();
              }
            }),
          ),
        ]),
      ),
    ],
  );
}
