// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../../models/app_state_model.dart';
import '../../../../models/vendor/store_model.dart';
import '../../../../models/vendor/store_state_model.dart';
import 'search_store.dart';
import 'store_list/store_list.dart';

class Stores extends StatefulWidget {
  final Map<String, dynamic> filter;
  final StoreStateModel model = StoreStateModel();

  Stores({required Key key, required this.filter}) : super(key: key);
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  final ScrollController _scrollController = ScrollController();
  AppStateModel appStateModel = AppStateModel();
  @override
  void initState() {
    super.initState();
    widget.model.filter = widget.filter.cast<String, String>();
      widget.model.getAllStores();
    _scrollController.addListener(_loadMoreItems);
  }

  _loadMoreItems() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        widget.model.hasMoreItems) {
      widget.model.loadMoreStores();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreItems);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: buildStoreTitle(context),),
      body: RefreshIndicator(
        onRefresh: () async {
          await widget.model.refresh();
          return;
        },
        child: ScopedModel<StoreStateModel>(
            model: widget.model,
            child: ScopedModelDescendant<StoreStateModel>(
                builder: (context, child, model) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: buildListOfBlocks(model.stores, model),
              );
            })),
      ),
    );
  }

  List<Widget> buildListOfBlocks(
      List<StoreModel> stores, StoreStateModel model) {
    List<Widget> list = List<Widget>.empty(growable: true);
    list.add(StoresList(key: UniqueKey(), stores: stores));
    list.add(SliverPadding(
        padding: EdgeInsets.all(0.0),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          model.hasMoreItems
              ? SizedBox(
                  height: 60, child: Center(child: CircularProgressIndicator()))
              : Container()
        ]))));

    return list;
  }

  Row buildStoreTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
                  return SearchStores();
                }));
              },
              child: TextField(
                showCursor: false,
                enabled: false,
                decoration: InputDecoration(
                  hintText: appStateModel.blocks.localeText.searchStores,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Circular',
                  ),
                  //fillColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).inputDecorationTheme.fillColor : Colors.white,
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
      ],
    );
  }
}
