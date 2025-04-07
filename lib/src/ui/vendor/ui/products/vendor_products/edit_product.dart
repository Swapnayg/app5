// ignore_for_file: library_private_types_in_public_api, unused_field, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../../config.dart';
import '../../../../../models/app_state_model.dart';
import '../../../../../models/vendor/vendor_product_model.dart';
import '../../../../../resources/api_provider.dart';
import '../variation_products/vatiation_product_list.dart';
import 'attributes.dart';
import 'select_categories.dart';

class EditVendorProduct extends StatefulWidget {
  final VendorBloc vendorBloc;
  final VendorProduct product;

  const EditVendorProduct({super.key, required this.vendorBloc, required this.product});
  @override
  _EditVendorProductState createState() => _EditVendorProductState();
}

class _EditVendorProductState extends State<EditVendorProduct> {
  AppStateModel appStateModel = AppStateModel();
  final _formKey = GlobalKey<FormState>();
  final _apiProvider = ApiProvider();
  late File imageFile;
  bool isImageUploading = false;
  Config config = Config();


  @override
  void initState() {
    super.initState();
  }

  void handleTypeValueChanged(String? value) {
    if (value != null) {
      setState(() {
        widget.product.type = value;
      });
    }
  }

  void handleStatusTypeValueChanged(String? value) {
    if (value != null) {
      setState(() {
        widget.product.status = value;
      });
    }
  }

  void handleStockStatusValueChanged(String? value) {
    if (value != null) {
      setState(() {
        widget.product.stockStatus = value;
      });
    }
  }

  void handleCatalogVisibilityTypeValueChanged(String? value) {
    if (value != null) {
      setState(() {
        widget.product.catalogVisibility = value;
      });
    }
  }

  void handleBackOrdersValueChanged(String? value) {
    if (value != null) {
      setState(() {
        widget.product.backOrders = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(appStateModel.blocks.localeText.edit),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      initialValue: widget.product.name,
                      decoration: InputDecoration(
                        labelText: '${appStateModel.blocks.localeText.product} ${appStateModel.blocks.localeText.name}',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '${appStateModel.blocks.localeText.pleaseEnter} ${appStateModel.blocks.localeText.product} ${appStateModel.blocks.localeText.name}';
                        }
                        return null;
                      },
                      onSaved: (val) =>
                          setState(() => widget.product.name = val!),
                    ),

                    const SizedBox(height: 16.0),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /*  RaisedButton(
                                onPressed: _choose,
                                child: Text("Choose Image")
                            ),*/
                          ],
                        ),
                        widget.product.images.length >= 0
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: widget.product.images.length + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                itemBuilder: (BuildContext context, int index) {
                                  if (widget.product.images.length > index) {
                                    return Stack(
                                      children: <Widget>[
                                        Card(
                                            clipBehavior: Clip.antiAlias,
                                            
                                            margin: EdgeInsets.all(4.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Image.network(
                                                widget
                                                    .product.images[index].src,
                                                fit: BoxFit.cover)),
                                        Positioned(
                                          top: -5,
                                          right: -5,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                            onPressed: () => removeImage(
                                                widget.product.images[index]),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (widget.product.images.length ==
                                          index &&
                                      isImageUploading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Container(
                                        child: GestureDetector(
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        margin: EdgeInsets.all(4.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Icon(Icons.add_a_photo, size: 48, color: Theme.of(context).focusColor,),
                                      ),
                                      onTap: () => _choose(),
                                    ));
                                  }
                                })
                            : Container(),
                      ],
                    ),
                    //Text(urls),

                    _buildCategoryTile(),

                    _buildAttributesTile(),

                    const SizedBox(height: 16.0),
                    Text(appStateModel.blocks.localeText.type, style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'simple',
                          groupValue: widget.product.type,
                          onChanged: handleTypeValueChanged,
                        ),
                        Text(
                          appStateModel.blocks.localeText.simple,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'grouped',
                          groupValue: widget.product.type,
                          onChanged: handleTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.grouped,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      Radio<String>(
                        value: 'external',
                        groupValue: widget.product.type,
                        onChanged: handleTypeValueChanged,
                      ),
                      Text(
                          appStateModel.blocks.localeText.external,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Radio<String>(
                        value: 'variable',
                        groupValue: widget.product.type,
                        onChanged: handleTypeValueChanged,
                      ),
                      Text(
                          appStateModel.blocks.localeText.variable,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ]),

                    const SizedBox(height: 16.0),
                    Text("Status", style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'draft',
                          groupValue: widget.product.status,
                          onChanged: handleStatusTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.draft,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'pending',
                          groupValue: widget.product.status,
                          onChanged: handleStatusTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.pending,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'private',
                          groupValue: widget.product.status,
                          onChanged: handleStatusTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.private,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'publish',
                          groupValue: widget.product.status,
                          onChanged: handleStatusTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.publish,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),
                    Text(appStateModel.blocks.localeText.catalogVisibility, style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'visible',
                          groupValue: widget.product.catalogVisibility,
                          onChanged: handleCatalogVisibilityTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.visible,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'catalog',
                          groupValue: widget.product.catalogVisibility,
                          onChanged: handleCatalogVisibilityTypeValueChanged,
                        ),
                        Text(
                          "Catalog",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'search',
                          groupValue: widget.product.catalogVisibility,
                          onChanged: handleCatalogVisibilityTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.search,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'hidden',
                          groupValue: widget.product.catalogVisibility,
                          onChanged: handleCatalogVisibilityTypeValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.hidden,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),

                    /* TextFormField(
                      initialValue: widget.product.stockQuantity.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Stock Quantity"),
                      onSaved: (val) => setState(
                              () => widget.product.stockQuantity = int.parse(val)),
                    ),*/

                    const SizedBox(height: 16.0),
                    Text(appStateModel.blocks.localeText.stockStatus, style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'instock',
                          groupValue: widget.product.stockStatus,
                          onChanged: handleStockStatusValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.inStock,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'outofstock',
                          groupValue: widget.product.stockStatus,
                          onChanged: handleStockStatusValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.outOfStock,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    /*Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'onbackorder',
                          groupValue: widget.product.stockStatus,
                          onChanged: handleStockStatusValueChanged,
                        ),
                        new Text(
                            appStateModel.blocks.localeText.stockStatus,
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),*/
                    const SizedBox(height: 16.0),
                    Text(appStateModel.blocks.localeText.backOrder, style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'no',
                          groupValue: widget.product.backOrders,
                          onChanged: handleBackOrdersValueChanged,
                        ),
                        Text(
                          appStateModel.blocks.localeText.no,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'notify ',
                          groupValue: widget.product.backOrders,
                          onChanged: handleBackOrdersValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.notify,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<String>(
                          value: 'yes',
                          groupValue: widget.product.backOrders,
                          onChanged: handleBackOrdersValueChanged,
                        ),
                        Text(
                            appStateModel.blocks.localeText.yes,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),

                    TextFormField(
                      decoration: InputDecoration(labelText: appStateModel.blocks.localeText.weight,),
                      /* validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter weight';
                        }
                      },*/
                      onSaved: (val) => setState(() => widget.product.weight),
                    ),

                    TextFormField(
                      initialValue: widget.product.sku,
                      decoration: InputDecoration(
                        labelText: "sku",
                      ),
                      onSaved: (val) =>
                          setState(() => widget.product.sku = val!),
                    ),

                    TextFormField(
                      initialValue: widget.product.shortDescription,
                      decoration:
                          InputDecoration(labelText: appStateModel.blocks.localeText.description,),
                      onSaved: (val) =>
                          setState(() => widget.product.shortDescription = val!),
                    ),

                    TextFormField(
                      initialValue: widget.product.description,
                      decoration: InputDecoration(labelText: '${appStateModel.blocks.localeText.description} ${appStateModel.blocks.localeText.description}'),
                      onSaved: (val) =>
                          setState(() => widget.product.description = val!),
                    ),
                    TextFormField(
                      initialValue: widget.product.price,
                      decoration: InputDecoration(labelText: appStateModel.blocks.localeText.price,),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '${appStateModel.blocks.localeText.pleaseEnter} ${appStateModel.blocks.localeText.price}';
                        }
                        return null;
                      },
                      onSaved: (val) =>
                          setState(() => widget.product.price = val!),
                    ),
                    TextFormField(
                      initialValue: widget.product.regularPrice,
                      decoration: InputDecoration(labelText: appStateModel.blocks.localeText.regularPrice,),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '${appStateModel.blocks.localeText.pleaseEnter} ${appStateModel.blocks.localeText.regularPrice}';
                        }
                        return null;
                      },
                      onSaved: (val) =>
                          setState(() => widget.product.regularPrice = val!),
                    ),
                    TextFormField(
                      initialValue: widget.product.salePrice,
                      decoration: InputDecoration(labelText: appStateModel.blocks.localeText.salesPrice,),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '${appStateModel.blocks.localeText.pleaseEnter} ${appStateModel.blocks.localeText.salesPrice}';
                        }
                        return null;
                      },
                      onSaved: (val) =>
                          setState(() => widget.product.salePrice = val!),
                    ),

                    TextFormField(
                      initialValue: widget.product.purchaseNote,
                      decoration: InputDecoration(labelText: appStateModel.blocks.localeText.purchaseNote,),
                      onSaved: (val) =>
                          setState(() => widget.product.purchaseNote),
                    ),

                    const SizedBox(height: 16.0),
                    widget.product.type == "variable" ?
                        ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          title: Text(appStateModel.blocks.localeText.variations,),
                          trailing: Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VariationProductList(
                                        vendorBloc: widget.vendorBloc,
                                        product: widget.product,
                                      ),
                                ),
                              );
                            }
                        )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text(appStateModel.blocks.localeText.submit),
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              widget.vendorBloc.editProduct(widget.product);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _choose() async {
    //set state image uploading true
    //imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    _upload();
    }

  void _upload() async {
    setState(() {
      isImageUploading = true;
    });
    var request = http.MultipartRequest(
        "POST",
        Uri.parse("${config.url}/wp-admin/admin-ajax.php?action=mstoreapp_upload_image"));
    var pic = await http.MultipartFile.fromPath("file", imageFile.path);
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    Map<String, dynamic> fileUpload = jsonDecode(responseString);
    FileUploadResponse uploadedFile = FileUploadResponse.fromJson(fileUpload);

    ProductImage picture = ProductImage(
      id: 0, // Replace with appropriate value
      dateCreated: DateTime.now(), // Replace with appropriate value
      dateCreatedGmt: DateTime.now().toUtc(), // Replace with appropriate value
      dateModified: DateTime.now(), // Replace with appropriate value
      dateModifiedGmt: DateTime.now().toUtc(), // Replace with appropriate value
      src: '', // Replace with appropriate value
      name: '', // Replace with appropriate value
      alt: '', // Replace with appropriate value
    );
    picture.src = uploadedFile.url;
    setState(() {
      widget.product.images.add(picture);
      isImageUploading = false;
    });
    }

  removeImage(ProductImage imag) {
    if (widget.product.images.length > 1) {
      setState(() {
        widget.product.images.remove(imag);
      });
    } else {
    }
  }

  _buildCategoryTile() {
    String option = '';
    widget.product.categories.forEach((value) {
      option = option.isEmpty ? value.name : '$option, ${value.name}';
    });
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectCategories(product: widget.product))),
      title: Text("Categories"),
      //isThreeLine: true,
      subtitle: option.isNotEmpty ? Text(option, maxLines: 1, overflow: TextOverflow.ellipsis) : null,
      trailing: Icon(CupertinoIcons.forward),
    );
  }

  _buildAttributesTile() {
    String option = '';
    widget.product.attributes.forEach((value) {
      option = option.isEmpty ? value.name : '$option, ${value.name}';
    });
    return ListTile(
        contentPadding: EdgeInsets.all(0.0),
        title: Text('Attributes'),
        trailing: Icon(CupertinoIcons.forward),
        subtitle: option.isNotEmpty ? Text(option, maxLines: 1, overflow: TextOverflow.ellipsis) : null,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SelectAttributes(
                    vendorBloc: widget.vendorBloc,
                    product: widget.product,
                  ),
            ),
          );
        }
    );
  }

}

class FileUploadResponse {
  final String url;

  FileUploadResponse(this.url);

  FileUploadResponse.fromJson(Map<String, dynamic> json) : url = json['url'];

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}
