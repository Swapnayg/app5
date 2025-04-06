// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../models/orders_model.dart';
import '../../../../models/vendor/product_variation_model.dart' hide VariationImage;
import '../../../../models/vendor/vendor_product_model.dart';
import 'variation_item.dart';


class AddVariations extends StatefulWidget {
  final VendorBloc vendorBloc;
  final VendorProduct product;
  final Order order;
  const AddVariations({super.key, required this.product, required this.vendorBloc, required this.order});

  @override
  _AddVariationsState createState() => _AddVariationsState();
}


class _AddVariationsState extends State<AddVariations> {
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    widget.vendorBloc.getVariationProducts(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Variation Products'),

          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                semanticLabel: 'done',
              ),
              onPressed: () {
                Navigator.pop(
                    context);
              },
            ),
          ]),


      body: StreamBuilder(
          stream: widget.vendorBloc.allVendorVariationProducts,
          builder: (context, AsyncSnapshot<List<ProductVariation>> snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                  controller: _scrollController, slivers: buildList(snapshot));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildListTile(BuildContext context, ProductVariation product) {

    var name = '';
    for (var value in product.attributes) {
      name = '$name ${value.option}';
    }

    return VariationItem(vendorBloc: widget.vendorBloc, product: widget.product, order: widget.order, variation: ProductVariation(),);
  }

  Widget buildItemList(AsyncSnapshot<List<ProductVariation>> snapshot) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Column(
              children: <Widget>[
            VariationItem(vendorBloc: widget.vendorBloc, product: widget.product, order: widget.order, variation: snapshot.data![index]),
                Divider(height: 0.0),
              ],
            );
          },
          childCount: snapshot.data?.length,
        ));
  }

  buildList(AsyncSnapshot<List<ProductVariation>> snapshot) {
    List<Widget> list = [];
    list.add(buildItemList(snapshot));
    if (snapshot.data != null) {
      list.add(SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                    height: 60,
                    child: StreamBuilder<bool>(
                        stream: widget.vendorBloc.hasMoreProductsStream,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          return snapshot.hasData && snapshot.data == false
                              ? Center(child: Text('No more products!'))
                              : Center(child: Container());
                        }))
              ]))));
    }
    return list;
  }

}
