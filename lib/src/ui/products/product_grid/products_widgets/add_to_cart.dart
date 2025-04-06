// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

import './../../../../models/app_state_model.dart';
import './../../../../models/product_model.dart';
import 'grouped_products.dart';
import 'variations_products.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key? key,
    required this.product,
    required this.model,
  }) : super(key: key);

  final Product product;
  final AppStateModel model;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (getQty() != 0 || isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OverflowBar(
            alignment: MainAxisAlignment.end,
            spacing: 0.0,
            // this will take space as minimum as posible(to center)
            children: <Widget>[
              SizedBox(
                height: 30,
                width: 30,
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4)),
                  ),
                  child: Icon(Icons.remove),
                  onPressed: () {
                    if (widget.product.type == 'variable' ||
                        widget.product.type == 'grouped') {
                      _bottomSheet(context);
                    } else {
                      decreaseQty();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: isLoading
                      ? SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onPrimary),
                    ),
                  )
                      : SizedBox(
                    width: 20.0,
                    child: Text(
                      getQty().toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                  ),
                  child: Icon(Icons.add),
                  onPressed: () {
                    if (widget.product.type == 'variable' ||
                        widget.product.type == 'grouped') {
                      _bottomSheet(context);
                    } else {
                      increaseQty();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OverflowBar(
              SizedBox(
                height: 30,
                width: 60,
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4)),
                  ),
                  child: Text(widget.model.blocks.localeText.add.toUpperCase()),
                  onPressed: widget.product.stockStatus == 'outofstock'
                      ? null
                      : () {
                    if (widget.product.type == 'variable' ||
                        widget.product.type == 'grouped') {
                      _bottomSheet(context);
                    } else {
                      addToCart(context);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                  ),
                  child: Icon(Icons.add),
                  onPressed: widget.product.stockStatus == 'outofstock'
                      ? null
                      : () {
                    if (widget.product.type == 'variable' ||
                        widget.product.type == 'grouped') {
                      _bottomSheet(context);
                    } else {
                      addToCart(context);
                    }
                  },
                ),
              ),
      ]
          ),
        ],
      );
    }
  }

  addToCart(BuildContext context) async {
    var data = <String, dynamic>{};
    data['product_id'] = widget.product.id.toString();
    data['quantity'] = '1';
    setState(() {
      isLoading = true;
    });
    await widget.model.addToCart(data);
    setState(() {
      isLoading = false;
    });
  }

  decreaseQty() async {
    if (widget.model.shoppingCart.cartContents != null) {
      if (widget.model.shoppingCart.cartContents
          .any((cartContent) => cartContent.productId == widget.product.id)) {
        final cartContent = widget.model.shoppingCart.cartContents.singleWhere(
                (cartContent) => cartContent.productId == widget.product.id);
        setState(() {
          isLoading = true;
        });
        await widget.model.decreaseQty(cartContent.key, cartContent.quantity);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  increaseQty() async {
    if (widget.model.shoppingCart.cartContents != null) {
      if (widget.model.shoppingCart.cartContents
          .any((cartContent) => cartContent.productId == widget.product.id)) {
        final cartContent = widget.model.shoppingCart.cartContents.singleWhere(
                (cartContent) => cartContent.productId == widget.product.id);
        setState(() {
          isLoading = true;
        });
        bool status = await widget.model
            .increaseQty(cartContent.key, cartContent.quantity);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  getQty() {
    var count = 0;
    if (widget.model.shoppingCart.cartContents
        .any((element) => element.productId == widget.product.id)) {
      if (widget.product.type == 'variable') {
        widget.model.shoppingCart.cartContents
            .where((variation) => variation.productId == widget.product.id)
            .toList()
            .forEach((e) {count = count + e.quantity;});
        return count;
      } else {
        return widget.model.shoppingCart.cartContents
            .firstWhere((element) => element.productId == widget.product.id)
            .quantity;
      }
    } else if (widget.product.type == 'grouped') {
      widget.model.shoppingCart.cartContents
          .where((product) => widget.product.children.map((e) => e.id).contains(product.productId))
          .toList()
          .forEach((e) {count = count + e.quantity;});
      return count;
    } else {
      return count;
    }
  }

  void _bottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Text(
                          widget.product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                if (widget.product.type == 'variable')
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.product.availableVariations.length,
                        itemBuilder: (BuildContext ctxt, int Index) {
                          return VariationProduct(
                              id: widget.product.id,
                              variation:
                              widget.product.availableVariations[Index],
                              addonFormKey: GlobalKey<FormState>(),
                              addOnsFormData: {});
                        }),
                  )
                else
                  widget.product.children.length > 0
                      ? Expanded(
                    child: ListView.builder(
                        itemCount: widget.product.children.length,
                        itemBuilder: (BuildContext ctxt, int Index) {
                          return GroupedProduct(
                              id: widget.product.id,
                              product: widget.product.children[Index]);
                        }),
                  )
                      : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
