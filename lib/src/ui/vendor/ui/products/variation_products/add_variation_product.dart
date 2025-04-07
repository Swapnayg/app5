// ignore_for_file: use_super_parameters, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../../models/vendor/product_attribute_model.dart';
import '../../../../../models/vendor/product_variation_model.dart';
import '../../../../../models/vendor/vendor_product_model.dart';
import '../../../../../models/vendor/product_variation_model.dart' as variation_model;
import '../../../../../models/vendor/product_attribute_model.dart' as attribute_model;

class AddVariations extends StatefulWidget {
  final VendorBloc vendorBloc;
  final VendorProduct product;

  const AddVariations({Key? key, required this.vendorBloc, required this.product}) : super(key: key);
  @override
  _AddVariationsState createState() => _AddVariationsState();
}

class _AddVariationsState extends State<AddVariations> {
  final _formKey = GlobalKey<FormState>();

  ProductVariation variationProduct = ProductVariation(
    id: 0, // Provide appropriate default or fetched value
    dateCreated: DateTime.now(), // Example default value
    dateCreatedGmt: DateTime.now(), // Example default value
    dateModified: DateTime.now(), // Example default value
    dateModifiedGmt: DateTime.now(), // Example default value
    description: '', // Provide appropriate default or fetched value
    permalink: '', // Provide appropriate default or fetched value
    sku: '', // Provide appropriate default or fetched value
    price: '', // Provide appropriate default or fetched value
    regularPrice: '', // Provide appropriate default or fetched value
    salePrice: '', // Provide appropriate default or fetched value
    onSale: false, // Example default value
    status: '', // Provide appropriate default or fetched value
    purchasable: false, // Example default value
    virtual: false, // Example default value
    downloadable: false, // Example default value
    downloads: [], // Example default value
    downloadLimit: 0, // Example default value
    downloadExpiry: 0, // Example default value
    taxStatus: '', // Provide appropriate default or fetched value
    taxClass: '', // Provide appropriate default or fetched value
    manageStock: false, // Example default value
    stockStatus: '', // Provide appropriate default or fetched value
    backorders: '', // Provide appropriate default or fetched value
    backordersAllowed: false, // Example default value
    backordered: false, // Example default value
    weight: '', // Provide appropriate default or fetched value
    dimensions: variation_model.Dimensions(length: '', width: '', height: ''), // Example default value
    shippingClass: '', // Provide appropriate default or fetched value
    shippingClassId: 0, // Example default value
    image: VariationImage(id: 0, dateCreated: DateTime(0), dateCreatedGmt: DateTime(0), dateModified: DateTime(0), dateModifiedGmt: DateTime(0), src: '', name: '', alt: ''), // Example default value
    attributes: [], // Example default value
    menuOrder: 0, // Example default value
    metaData: [], // Example default value
    links: variation_model.Links(collection: [], self: [], up: []), // Example default value
    images: [], // Example default value
  );
  ProductAttribute attribute = ProductAttribute(
    id: 0, // Provide appropriate default or fetched value
    name: '', // Provide appropriate default or fetched value
    slug: '', // Provide appropriate default or fetched value
    type: '', // Provide appropriate default or fetched value
    orderBy: '', // Provide appropriate default or fetched value
    hasArchives: false, // Example default value
    links: attribute_model.Links(collection: [], self: []), // Example default value
  );

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
                      VariationAttribute(id: 0, name: '', option: '');
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
