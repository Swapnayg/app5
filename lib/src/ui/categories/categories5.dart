// ignore_for_file: library_private_types_in_public_api, dead_code, deprecated_member_use, avoid_unnecessary_containers, non_constant_identifier_names

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../src/models/app_state_model.dart';
import '../../functions.dart';
import '../../models/blocks_model.dart' hide Image, Key;
import '../../models/category_model.dart';
import '../products/products.dart';

class Categories5 extends StatefulWidget {
  const Categories5({super.key});

  @override
  _Categories5State createState() => _Categories5State();
}

class _Categories5State extends State<Categories5> {

  late List<Category> mainCategories;
  late List<Category> subCategories;
  late Category selectedCategory;
  int mainCategoryId = 0;
  int selectedCategoryIndex = 0;
  AppStateModel appStateModel = AppStateModel();

  @override
  Widget build(BuildContext context) {
    //final ThemeData localTheme = Theme.of(context);
    return ScopedModelDescendant<AppStateModel>(
      builder: (context, child, model) {
        mainCategories = model.blocks.categories.where((cat) => cat.parent == 0).toList();
        selectedCategory = mainCategories[selectedCategoryIndex];
        subCategories = model.blocks.categories.where((cat) => cat.parent == selectedCategory.id).toList();

        return buildList(model.blocks);
      return Center(child: CircularProgressIndicator());
      },
    );
  }

  buildList(BlocksModel snapshot) {

    Color backgroundColor = Theme.of(context).focusColor.withOpacity(0.02);

    return Scaffold(
      appBar: AppBar(title: Text(appStateModel.blocks.localeText.categories)),
      body: Container(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              //color: Theme.of(context).canvasColor,
              child: ListView.builder(
                  itemCount: mainCategories.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          mainCategoryId = mainCategories[index].id;
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        decoration: selectedCategory.id == mainCategories[index].id
                            ? BoxDecoration(
                          border: Border(
                            left: BorderSide( //                   <--- left side
                              color: Theme.of(context).colorScheme.secondary,
                              width: 4.0,
                            ),
                          ),
                        ) : null,
                        child: Container(
                          color: selectedCategory.id == mainCategories[index].id
                              ? backgroundColor
                              : null,
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: CachedNetworkImage(
                                  imageUrl: mainCategories[index].image,
                                  placeholder: (context, url) =>
                                      Container(color: Colors.transparent),
                                  errorWidget: (context, url, error) => Container(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 4,),
                              Text(
                                parseHtmlString(mainCategories[index].name),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: selectedCategory.id == mainCategories[index].id
                                    ? TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w800)
                                    : TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide( //                   <--- left side
                      color: backgroundColor,
                      width: 8.0,
                    ),
                    top: BorderSide( //                    <--- top side
                      color: backgroundColor,
                      width: 8.0,
                    ),
                    right: BorderSide( //                    <--- top side
                      color: backgroundColor,
                      width: 8.0,
                    ),
                  ),
                ),
                //padding: EdgeInsets.all(8.0),
                //color: Theme.of(context).canvasColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              var filter = <String, dynamic>{};
                              filter['id'] = selectedCategory.id.toString();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductsWidget(
                                          filter: filter, name: selectedCategory.name)));
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: CachedNetworkImage(
                                imageUrl: selectedCategory.image,
                                imageBuilder: (context, imageProvider) => Ink.image(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  child: InkWell(
                                    onTap: () {
                                      var filter = new Map<String, dynamic>();
                                      filter['id'] = selectedCategory.id.toString();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductsWidget(
                                                  filter: filter, name: selectedCategory.name)));
                                    },
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Container(color: Colors.transparent),
                                errorWidget: (context, url, error) => Container(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide( //                   <--- left side
                                  color: backgroundColor,
                                  width: 8.0,
                                ),
                              )
                          ),
                          //color: Theme.of(context).focusColor,
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: MediaQuery.of(context).size.width ~/ 120, childAspectRatio: 7/9),
                              itemCount: subCategories.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Container(
                                    child: CategoryItem(subCategories[index], index, snapshot.categories));
                              }),
                        ))

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CategoryItem(Category category, int i, List<Category> categories) {
    return InkWell(
      onTap: () {
        var filter = <String, dynamic>{};
        filter['id'] = category.id.toString();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsWidget(
                    filter: filter, name: category.name)));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CachedNetworkImage(
                    imageUrl: category.image,
                    imageBuilder: (context, imageProvider) => Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Ink.image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {
                            var filter = <String, dynamic>{};
                            filter['id'] = category.id.toString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsWidget(
                                        filter: filter, name: category.name)));
                          },
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Card(clipBehavior: Clip.antiAlias,
                      elevation: 0.0,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),),
                    errorWidget: (context, url, error) => Card(clipBehavior: Clip.antiAlias,
                      elevation: 0.0,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    parseHtmlString(category.name),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 10.0,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}