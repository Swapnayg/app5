// ignore_for_file: use_super_parameters, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../../models/vendor/product_attribute_model.dart';
import '../../../../../models/vendor/product_variation_model.dart';
import '../../../../../models/vendor/vendor_product_model.dart';

class AddVariations extends StatefulWidget {
  final VendorBloc vendorBloc;
  final VendorProduct product;

  const AddVariations({Key? key, required this.vendorBloc, required this.product}) : super(key: key);
  @override
  _AddVariationsState createState() => _AddVariationsState();
}

class _AddVariationsState extends State<AddVariations> {
  final _formKey = GlobalKey<FormState>();

  ProductVariation variationProduct = ProductVariation();
  ProductAttribute attribute = ProductAttribute();

  @override
  void initState() {
    super.initState();
  }

  void handlestockStatusValueChanged(String? value) {
    if (value != null) {
      setState(() {
        variationProduct.stockStatus = value;
      });
    }
  }

  void handleStatusTypeValueChanged(String value) {
    setState(() {
      variationProduct.status = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Variation"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(slivers: _buildList()),
        ));
  }

  _buildList() {
    List<Widget> list = [];

    for (var attribute in widget.product.attributes) {
      if (attribute.variation) {
        String selected = attribute.options.first;
        if (variationProduct.attributes
            .any((item) => item.name == attribute.name)) {
          selected = variationProduct.attributes
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
              onChanged: (String? newValue) {
                if (newValue != null) {
                  VariationAttribute variationAttribute =
                      VariationAttribute();
                  variationAttribute.id = attribute.id;
                  variationAttribute.name = attribute.name;
                  variationAttribute.option = newValue;

                  if (variationProduct.attributes
                      .any((item) => item.id == attribute.id)) {
                    setState(() {
                      variationProduct.attributes
                          .removeWhere((item) => item.id == attribute.id);
                    });
                    setState(() {
                      variationProduct.attributes.add(variationAttribute);
                    });
                  } else {
                    setState(() {
                      variationProduct.attributes.add(variationAttribute);
                    });
                  }
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
              decoration: InputDecoration(
                labelText: "Sku",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter products Sku";
                }
                return null;
              },
              onSaved: (val) => setState(() => variationProduct.sku = val!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Description"),
              onSaved: (val) =>
                  setState(() => variationProduct.description = val!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Regular Price"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter regular price";
                }
                return null;
              },
              onSaved: (val) =>
                  setState(() => variationProduct.regularPrice = val!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Sale Price"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter sale price";
                }
                return null;
              },
              onSaved: (val) =>
                  setState(() => variationProduct.salePrice = val!),
            ),
            const SizedBox(height: 16.0),
            Text("Stock Status", style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: "instock",
                  groupValue: variationProduct.stockStatus,
                  onChanged: handlestockStatusValueChanged,
                ),
                Text(
                  "Instock",
                  style: TextStyle(fontSize: 16.0),
                ),
                Radio<String>(
                  value: "outofstock",
                  groupValue: variationProduct.stockStatus,
                  onChanged: handlestockStatusValueChanged,
                ),
                Text(
                  "Outof Stock",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'onbackorder',
                  groupValue: variationProduct.stockStatus,
                  onChanged: handlestockStatusValueChanged,
                ),
                Text(
                  "onbackorder",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      widget.vendorBloc.addVariationProduct(
                          widget.product.id, variationProduct);

                      // Navigator.pop(context);
                    }
                  },
                  child: Text("Submit"),
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
