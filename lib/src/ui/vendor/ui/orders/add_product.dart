// ignore_for_file: library_private_types_in_public_api, unused_element, avoid_print

import 'package:app5/src/models/vendor/product_variation_model.dart';
import 'package:app5/src/models/vendor/vendor_product_model.dart';
import 'package:flutter/material.dart';

import '../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../models/orders_model.dart';
import '../../../../models/vendor/product_variation_model.dart' as variation_model;
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

            return ProductItem(
              vendorBloc: widget.vendorBloc,
              product: snapshot.data![index],
              order: widget.order,
              variation: ProductVariation(
                id: snapshot.data![index].id,
                dateCreated: snapshot.data![index].dateCreated,
                dateCreatedGmt: snapshot.data![index].dateCreatedGmt,
                dateModified: snapshot.data![index].dateModified,
                dateModifiedGmt: snapshot.data![index].dateModifiedGmt,
                description: snapshot.data![index].description,
                permalink: snapshot.data![index].permalink,
                sku: snapshot.data![index].sku,
                price: snapshot.data![index].price,
                regularPrice: snapshot.data![index].regularPrice,
                salePrice: snapshot.data![index].salePrice,
                onSale: snapshot.data![index].onSale,
                status: snapshot.data![index].status,
                purchasable: snapshot.data![index].purchasable,
                virtual: snapshot.data![index].virtual,
                downloadable: snapshot.data![index].downloadable,
                downloads: snapshot.data![index].downloads,
                downloadLimit: snapshot.data![index].downloadLimit,
                downloadExpiry: snapshot.data![index].downloadExpiry,
                taxStatus: snapshot.data![index].taxStatus,
                taxClass: snapshot.data![index].taxClass,
                manageStock: snapshot.data![index].manageStock,
                stockStatus: snapshot.data![index].stockStatus,
                backorders: snapshot.data![index].backOrders,
                backordersAllowed: snapshot.data![index].backordersAllowed,
                backordered: snapshot.data![index].backordered,
                weight: snapshot.data![index].weight,
                //dimensions : snapshot.data![index].dimensions,
                shippingClass: snapshot.data![index].shippingClass,
                shippingClassId: snapshot.data![index].shippingClassId,
                images: snapshot.data![index].images,
                metaData: snapshot.data![index].metaData, 
                dimensions: variation_model.Dimensions(length: '', width: '', height: ''), image: VariationImage(id: 0, dateCreated: DateTime(0), dateCreatedGmt: DateTime(0), dateModified: DateTime(0), dateModifiedGmt: DateTime(0), src: '', name: '', alt: ''), attributes: [], links: variation_model.Links(collection: [], self: [], up: []), menuOrder: 0,
                // Replace with actual values if available
                //attributes: snapshot.data![index].attributes,
                //links: snapshot.data![index].links,
              ),
            );
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
    final lineItem = LineItem(
      id: 0, // Provide a valid id
      name: product.name, // Use product name or a default value
      productId: product.id,
      variationId: 0, // Provide a valid variationId if applicable
      quantity: 1,
      taxClass: '', // Provide a valid tax class if applicable
      subtotal: '0.0', // Provide a valid subtotal
      subtotalTax: '0.0', // Provide a valid subtotal tax
      total: '0.0', // Provide a valid total
      totalTax: '0.0', // Provide a valid total tax
      taxes: [], // Provide a valid list of taxes
      metaData: [], // Provide a valid list of metadata
      sku: product.sku, // Use product SKU or a default value
      price: double.tryParse(product.price) ?? 0.0, // Use product price or a default value
    );
    lineItem.productId = product.id;
    lineItem.quantity = 1;


    widget.order.lineItems.add(lineItem);

    print(widget.order.lineItems.length);
  }
}

