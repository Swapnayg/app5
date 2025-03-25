
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../../models/app_state_model.dart';
import '../../../../../models/vendor/product_attribute_model.dart';
import '../../../../../models/vendor/product_variation_model.dart';
import '../../../../../models/vendor/vendor_product_model.dart';

class EditVariationProduct extends StatefulWidget {
  final VendorBloc vendorBloc;
  final VendorProduct product;
  final ProductVariation variationProduct;

  const EditVariationProduct({Key key, this.vendorBloc, this.product, this.variationProduct}) : super(key: key);
  @override
  _EditVariationProductState createState() => _EditVariationProductState();
}

class _EditVariationProductState extends State<EditVariationProduct> {

  final AppStateModel _appStateModel = AppStateModel();

  final _formKey = GlobalKey<FormState>();

  ProductAttribute attribute = ProductAttribute();

  @override
  void initState() {
    super.initState();
    widget.variationProduct.attributes ??= [];

  }

  void handleStockStatusValueChanged(String value) {
    setState(() {
      widget.variationProduct.stockStatus = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(_appStateModel.blocks.localeText.variations),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(slivers: _buildList()),
        ));
  }

  _buildList() {
    List<Widget> list = List<Widget>();

    for (var attribute in widget.product.attributes) {
      if (attribute.variation) {
        String selected = attribute.options.first;
        if (widget.variationProduct.attributes
            .any((item) => item.name == attribute.name)) {
          selected = widget.variationProduct.attributes
              .singleWhere((item) => item.name == attribute.name)
              .option;
        }
        list.add(SliverToBoxAdapter(
          child: Container(
            child: Text(attribute.name,
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ));
        list.add(
          SliverToBoxAdapter(
            child: DropdownButton<String>(
              value: selected,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 25,
              elevation: 16,
              underline: Container(
                height: 1,
              ),
              onChanged: (String newValue) {
                VariationAttribute variationAttribute =
                VariationAttribute();
                variationAttribute.id = attribute.id;
                variationAttribute.name = attribute.name;
                variationAttribute.option = newValue;

                if (widget.variationProduct.attributes
                    .any((item) => item.id == attribute.id)) {
                  setState(() {
                    widget.variationProduct.attributes
                        .removeWhere((item) => item.id == attribute.id);
                  });
                  setState(() {
                    widget.variationProduct.attributes.add(variationAttribute);
                  });
                } else {
                  setState(() {
                    widget.variationProduct.attributes.add(variationAttribute);
                  });
                }
              },
              items: attribute.options
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      }
    }
    list.add(SliverToBoxAdapter(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: widget.variationProduct.sku,
              decoration: InputDecoration(
                labelText: _appStateModel.blocks.localeText.sku,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return '${_appStateModel.blocks.localeText.pleaseEnter} ${_appStateModel.blocks.localeText.sku}';
                } else {
                  return null;
                }
              },
              onSaved: (val) => setState(() => widget.variationProduct.sku = val),
            ),
            TextFormField(
            initialValue:  widget.variationProduct.description,
              decoration: InputDecoration(labelText: _appStateModel.blocks.localeText.description),
              onSaved: (val) =>
                  setState(() => widget.variationProduct.description = val),
            ),
            TextFormField(
              initialValue: widget.variationProduct.regularPrice,
              decoration: InputDecoration(labelText: _appStateModel.blocks.localeText.regularPrice),
              validator: (value) {
                if (value.isEmpty) {
                  return '${_appStateModel.blocks.localeText.pleaseEnter} ${_appStateModel.blocks.localeText.regularPrice}';
                } else {
                  return null;
                }
              },
              onSaved: (val) =>
                  setState(() => widget.variationProduct.regularPrice = val),
            ),
            TextFormField(
              initialValue: widget.variationProduct.salePrice,
              decoration: InputDecoration(labelText: _appStateModel.blocks.localeText.salesPrice),
              validator: (value) {
                if (value.isEmpty) {
                  return '${_appStateModel.blocks.localeText.pleaseEnter} ${_appStateModel.blocks.localeText.salesPrice}';
                } else {
                  return null;
                }
              },
              onSaved: (val) =>
                  setState(() => widget.variationProduct.salePrice = val),
            ),
            const SizedBox(height: 16.0),
            Text(_appStateModel.blocks.localeText.stockStatus, style: Theme
                .of(context)
                .textTheme
                .titleSmall),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'instock',
                  groupValue: widget.variationProduct.stockStatus,
                  onChanged: handleStockStatusValueChanged,
                ),
                Text(
                  _appStateModel.blocks.localeText.inStock,
                  style: TextStyle(fontSize: 16.0),
                ),
                Radio<String>(
                  value: 'outofstock',
                  groupValue: widget.variationProduct.stockStatus,
                  onChanged: handleStockStatusValueChanged,
                ),
                Text(
                  _appStateModel.blocks.localeText.outOfStock,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'onbackorder',
                  groupValue: widget.variationProduct.stockStatus,
                  onChanged: handleStockStatusValueChanged,
                ),
                Text(
                  _appStateModel.blocks.localeText.backOrder,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      widget.vendorBloc.editVariationProduct(widget.product.id, widget.variationProduct);

                      Navigator.pop(context);
                    }
                  },
                  child: Text(_appStateModel.blocks.localeText.save),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
    return list;
  }
}

