//import 'package:app/src/models/vendor/vendor_product_model.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../../../blocs/vendor/attribute_bloc.dart';
import '../../../../../models/vendor/product_attribute_model.dart';
import '../../../../../models/vendor/vendor_product_model.dart';

class AttributeOptionsPage extends StatefulWidget {
  final AttributeBloc attributeBloc;
  final ProductAttribute productAttribute;
  final VendorProduct product;

  const AttributeOptionsPage(
      {super.key,
      required this.productAttribute,
      required this.product,
      required this.attributeBloc});
  @override
  _AttributeOptionsPageState createState() => _AttributeOptionsPageState();
}

class _AttributeOptionsPageState extends State<AttributeOptionsPage> {

  @override
  void initState() {
    super.initState();
    widget.attributeBloc.fetchAllTerms(widget.productAttribute.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.productAttribute.name),
        ),
        body: StreamBuilder<List<AttributeTerms>>(
            stream: widget.attributeBloc.allTerms,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctxt, int index) =>
                          buildBody(ctxt, snapshot.data![index]))
                  : Center(child: CircularProgressIndicator());
            }));
  }

  buildBody(BuildContext ctxt, AttributeTerms attributesTerm) {
    var contains = false;

    if(widget.product.attributes.any((item) => item.id == widget.productAttribute.id)) {
      if(widget.product.attributes.singleWhere((item) => item.id == widget.productAttribute.id).options.contains(attributesTerm.name)) {
        contains = true;
      }
    }
    return ListTile(
      onTap: () => _onAttributesTermsTap(attributesTerm),
      title: Text(attributesTerm.name),
      trailing: Checkbox(
        value: contains,
        onChanged: (bool? value) {
          if (value != null) {
            _onAttributesTermsTap(attributesTerm);
          }
        },
      ),
    );
  }

  _onAttributesTermsTap(AttributeTerms term) {
    print('fdsafdsa');
    if(widget.product.attributes.any((item) => item.id == widget.productAttribute.id)) {
      if(widget.product.attributes.singleWhere((item) => item.id == widget.productAttribute.id).options.contains(term.name)) {
        setState(() {
          widget.product.attributes.singleWhere((item) => item.id == widget.productAttribute.id).options.remove(term.name);
        });
      } else {
        setState(() {
          widget.product.attributes.singleWhere((item) => item.id == widget.productAttribute.id).options.add(term.name);
        });
      }
    } else {
      Attribute attribute = Attribute(
        id: widget.productAttribute.id,
        name: widget.productAttribute.name,
        position: 0, // Provide a default or appropriate value
        visible: true, // Provide a default or appropriate value
        variation: false, // Provide a default or appropriate value
        options: [term.name],
      );
      setState(() {
        widget.product.attributes.add(attribute);
      });
    }
  }
}
