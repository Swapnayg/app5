
// ignore_for_file: library_private_types_in_public_api, dead_code

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/app_state_model.dart';
import '../../../models/delas_state_model.dart';
import '../../../models/product_model.dart';
import '../../../ui/products/product_grid/product_item.dart';

class Deals extends StatefulWidget {
  final AppStateModel appStateModel = AppStateModel();
  final DealsStateModel model = DealsStateModel();
  Deals({super.key});

  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.model.fetchDealProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.model.loadMoreDealsProduct();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await widget.model.refresh();
          return;
        },
        child: ScopedModel<DealsStateModel>(
          model: widget.model,
          child: ScopedModelDescendant<DealsStateModel>(
              builder: (context, child, model) {
            if (model.products.length != 0) {
              return CustomScrollView(
                controller: _scrollController,
                slivers:
                    buildLisOfBlocks(model.products, model.hasMoreItems),
              );
            } else {
              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Container(),
                    ],
                  ),
                  Center(
                    child: Text(
                        widget.appStateModel.blocks.localeText.noProducts),
                  )
                ],
              );
            }
                      return Center(child: CircularProgressIndicator());
          }),
        ));
  }

  List<Widget> buildLisOfBlocks(List<Product> products, bool hasMoreItems) {
    List<Widget> list = List<Widget>.empty(growable: true);
    if (products.length != 0) {
      list.add(ProductGrid(products: products));
      list.add(SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
                height: 60,
                child: hasMoreItems
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: Text(widget
                            .appStateModel.blocks.localeText.noMoreProducts)))
          ]))));
    }
    return list;
  }
}
