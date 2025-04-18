// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../functions.dart';
import '../../../models/app_state_model.dart';
import '../../../models/category_model.dart';
import '../../products/products.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ScopedModelDescendant<AppStateModel>(
            builder: (context, child, model) {
              List<Category> mainCategories = model.blocks.categories.where((cat) => cat.parent == 0).toList();
              return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Container(
                            padding:EdgeInsets.only(top: 10),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'WC',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Lexend_Deca',
                                    letterSpacing: 0.5,
                                    color: Colors.amber,
                                    fontSize: 20,
                                  ),),
                                Text(
                                  ' STORE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Lexend_Deca',
                                      letterSpacing: 0.5,
                                      color: Colors.redAccent,
                                      fontSize: 20
                                  ),),
                              ],
                            )
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                        height: 2,
                      ),
                    ]
                  )
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _buildTile(mainCategories[index]);
                    },
                    childCount: mainCategories.length,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        leading: Icon(Icons.bookmark, size: 25, color: leadingIconColor(),),
                        title: Text(
                          'FEATURED',
                          //style: menuItemStyle()
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).iconTheme.color!.withOpacity(0.2),),
                          onTap: () {
                            var filter = <String, dynamic>{};
                            filter['featured'] = '1';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsWidget(
                                        filter: filter,
                                        name: 'FEATURED')));
                          },
                      ),
                      _divider(context),
                      InkWell(
                        child: ListTile(
                          leading: Icon(
                            Icons.fiber_new,
                            size: 20,
                            color: leadingIconColor(),
                          ),
                          title: Text(
                            'NEW ARRIVALS',
                            //style: menuItemStyle()
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).iconTheme.color!.withOpacity(0.2),),
                          onTap: () {
                            var filter = <String, dynamic>{};
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsWidget(
                                        filter: filter,
                                        name: 'NEW ARRIVALS')));
                          },
                        ),
                      ),
                      _divider(context),
                      ListTile(
                        leading: Icon(
                          Icons.local_offer,
                          size: 20,
                          color: leadingIconColor(),
                        ),
                        title: Text(
                          'SALE',
                         // style: menuItemStyle()
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).iconTheme.color!.withOpacity(0.2),  ),
                        onTap: () {
                          var filter = <String, dynamic>{};
                          filter['on_sale'] = '1';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsWidget(
                                      filter: filter,
                                      name: 'SALE')));
                        },
                      ),
                      Divider(
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black45 : Colors.white,
                        thickness: 0.2,
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ],
            );
                        }),
      ),
    );
  }

  Color leadingIconColor() => Theme.of(context).brightness == Brightness.light ? Colors.blueGrey : Colors.grey;
  Color trailingIconColor() => Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.grey;

  Widget _buildTile(Category category) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              _onTap(category);
            },
            leading: leadingIcon(category),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).iconTheme.color!.withOpacity(0.2),),
            title: Text(
              parseHtmlString(category.name).toUpperCase(),
              //style: menuItemStyle()
            ),
          ),
          _divider(context),
        ],
      ),
    );
  }

  TextStyle menuItemStyle() {
    return TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'Lexend_Deca',
                letterSpacing: 0.5,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.8) : Colors.grey,
            );
  }

  SizedBox leadingIcon(Category category) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CachedNetworkImage(
        imageUrl: category.image,
        imageBuilder: (context, imageProvider) => Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0.0,
          margin: EdgeInsets.all(0.0),
          //shape: StadiumBorder(),
          child: Ink.image(
            image: imageProvider,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                //onCategoryClick(category);
              },
            ),
          ),
        ),
        placeholder: (context, url) => Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(0.0),
          elevation: 0.0,
          //shape: StadiumBorder(),
        ),
        errorWidget: (context, url, error) => Card(
          elevation: 0.0,
          margin: EdgeInsets.all(0.0),
          color: Theme.of(context).focusColor,
          //shape: StadiumBorder(),
        ),
      ),
    );
  }

  _onTap(Category category) {
    var filter = <String, dynamic>{};
    filter['id'] = category.id.toString();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsWidget(
                filter: filter,
                name: category.name)));
  }

  _divider(BuildContext context) {
    return Divider(
      thickness: 0.4,
      height: 1,
    );
  }

  void _onTapTag({String? tag, required String name}) {
    var filter = <String, dynamic>{};
    filter['tag'] = tag;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductsWidget(
                filter: filter,
                name: name)));
  }
}