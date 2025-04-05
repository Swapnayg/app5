// ignore_for_file: library_private_types_in_public_api, unused_element, avoid_print

import 'package:app5/src/models/vendor/product_variation_model.dart';
import 'package:flutter/material.dart';

import '../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../models/orders_model.dart';
import '../../../../models/vendor/vendor_product_model.dart';
import 'product_item.dart';


class AddProductList extends StatefulWidget {
  final VendorBloc vendorBloc;
final Order order;
   const AddProductList({super.key,required this.vendorBloc, required this.order});
  @override
  _AddProductListState createState() => _AddProductListState();
}

class _AddProductListState extends State<AddProductList> {
  final ScrollController _scrollController = ScrollController();
  Widget appBarTitle = Text("Order Products");


  @override
  void initState() {
    super.initState();
    widget.vendorBloc.fetchAllProducts();

    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          widget.vendorBloc.hasMoreProducts) {

        widget.vendorBloc.loadMoreProducts();
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
      ),


      body: StreamBuilder(
        stream: widget.vendorBloc.allVendorProducts,
        builder: (context,  AsyncSnapshot<List<VendorProduct>> snapshot) {
          if (snapshot.hasData) {
            return Stack(children: <Widget>[
              CustomScrollView(controller: _scrollController, slivers: [
                buildList(snapshot),
              ]),
              Positioned(
                bottom: 20.0,
                left: 30.0,
                right: 30.0,
                child: SizedBox(
                  width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 22),
                  ),
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ),
              ),
            ]);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },


      ),
    );
  }

  Widget buildList( AsyncSnapshot<List<VendorProduct>> snapshot) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {

            return ProductItem(vendorBloc: widget.vendorBloc, product: snapshot.data![index], order: widget.order, variation: ProductVariation());
          },
          childCount: snapshot.data?.length,
        ));
  }





  void _addProduct(VendorProduct product) {
    print(product.type);
    /*if(product.type == 'variable'){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddVariations(vendorBloc: widget.vendorBloc, product: product,)),
      );
    }*/
    final lineItem = LineItem();
    lineItem.productId = product.id;
    lineItem.quantity = 1;


    widget.order.lineItems.add(lineItem);

    print(widget.order.lineItems.length);
  }
}

