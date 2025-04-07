// ignore_for_file: library_private_types_in_public_api, unused_field, avoid_print, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../models/app_state_model.dart';
import '../../../../models/orders_model.dart';
import '../../../../models/vendor/product_variation_model.dart'
    hide VariationImage;
import '../../../../models/vendor/vendor_product_model.dart';

class VariationItem extends StatefulWidget {
  final VendorBloc vendorBloc;
  final VendorProduct product;
  final Order order;
  final ProductVariation variation;

  const VariationItem(
      {super.key, required this.product, required this.vendorBloc, required this.order, required this.variation});

  @override
  _VariationItemState createState() => _VariationItemState();
}

class _VariationItemState extends State<VariationItem> {
  final AppStateModel _appStateModel = AppStateModel();
  late NumberFormat formatter;

  var qty = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.variation.stockStatus);
    var name = '';

    for (var value in widget.variation.attributes) {
      name = '$name ${value.option}';
    }

    if (widget.order.lineItems.any((lineItems) => lineItems.productId == widget.product.id && lineItems.variationId == widget.variation.id)) {
      qty = widget.order.lineItems.singleWhere((lineItems) => lineItems.productId == widget.product.id && lineItems.variationId == widget.variation.id).quantity;
    }

    return Card(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 120,
            child: CachedNetworkImage(
              imageUrl: widget.variation.image.src,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Container(
                width: 120,
                height: 120,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.black12,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name),
              Text(formatter.format((double.parse(widget.variation.price)))),
              qty != 0
                  ? Container(
                      // width: 200,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                
                                _decreaseQty();
                              }),
                          Text(qty.toString()),
                          IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                
                                _increaseQty();
                              }),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              _addProduct();
                            }),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }

  void _addProduct() {
    print('hjhj');
    final lineItem = LineItem(
        id: 0, // Provide a unique ID or leave empty if not required
        name: widget.product.name,
        productId: widget.product.id,
        variationId: 0, // Set to null or provide a variation ID if applicable
        quantity: 1,
        taxClass: '', // Provide a tax class or leave empty if not required
        subtotal: (1 * double.parse(widget.product.price)).toString(),
        subtotalTax: '0', // Set to '0' or provide a value if applicable
        total: (1 * double.parse(widget.product.price)).toString(),
        totalTax: '0', // Set to '0' or provide a value if applicable
        taxes: [], // Provide a list of taxes if applicable
        metaData: [], // Provide metadata if applicable
        sku: widget.product.sku , // Use product SKU or leave empty
        price: double.parse(widget.product.price),
      );
    lineItem.productId = widget.product.id;
    lineItem.variationId = widget.variation.id;
    lineItem.quantity = 1;
    lineItem.name = widget.product.name;
    lineItem.price = double.parse(widget.variation.price);
    lineItem.total =
        (lineItem.quantity * double.parse(widget.variation.price)).toString();
    setState(() {
      widget.order.lineItems.add(lineItem);
    });
  }

  void _increaseQty() {
    if (widget.order.lineItems
        .any((lineItems) => lineItems.variationId == widget.variation.id)) {
      widget.order.lineItems
          .singleWhere(
              (lineItems) => lineItems.variationId == widget.variation.id)
          .quantity++;

      widget.order.lineItems
          .singleWhere(
              (lineItems) => lineItems.variationId == widget.variation.id)
          .total = (widget.order.lineItems
                  .singleWhere((lineItems) =>
                      lineItems.variationId == widget.variation.id)
                  .price *
              (qty + 1))
          .toString();
      setState(() {
        qty = qty + 1;
      });
    } else {
      _addProduct();
    }
  }

  void _decreaseQty() {
    if (widget.order.lineItems
        .any((lineItems) => lineItems.variationId == widget.variation.id)) {
      if (widget.order.lineItems
              .singleWhere(
                  (lineItems) => lineItems.variationId == widget.variation.id)
              .quantity ==
          0) {
        widget.order.lineItems.removeWhere(
            (lineItems) => lineItems.variationId == widget.variation.id);
        setState(() {
          qty = 0;
        });
      } else {
        widget.order.lineItems
            .singleWhere(
                (lineItems) => lineItems.variationId == widget.variation.id)
            .quantity--;
        widget.order.lineItems
            .singleWhere(
                (lineItems) => lineItems.variationId == widget.variation.id)
            .total = (widget.order.lineItems
                    .singleWhere((lineItems) =>
                        lineItems.variationId == widget.variation.id)
                    .price *
                (qty - 1))
            .toString();
        setState(() {
          qty = qty - 1;
        });
      }
    }
  }
}
