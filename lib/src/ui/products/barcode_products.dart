// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../blocs/product_detail_bloc.dart';
import '../../models/product_model.dart';
import '../../ui/products/product_detail/product_detail.dart';

class FindBarCodeProduct extends StatefulWidget {
  const FindBarCodeProduct({
    super.key,
    required this.result,
    required this.context,
  });

  final String result;
  final BuildContext context;

  @override
  _FindBarCodeProductState createState() => _FindBarCodeProductState();
}

class _FindBarCodeProductState extends State<FindBarCodeProduct> {
  bool loading = false;
  Product product = Product(
    id: 0,
    name: '',
    type: '',
    sku: '',
    price: 0.0,
    regularPrice: 0.0,
    status: '',
    featured: false,
    catalogVisibility: '',
    description: '',
    shortDescription: '',
    permalink: '',
    salePrice: 0.0,
    onSale: false,
    purchasable: false,
    totalSales: 0,
    virtual: false,
    downloadable: false,
    externalUrl: '',
    buttonText: '',
    manageStock: false,
    stockQuantity: 0,
    stockStatus: '',
    backorders: '',
    backordersAllowed: false,
    backordered: false,
    soldIndividually: false,
    weight: '',
    dimensions: Dimensions(length: '', width: '', height: ''),
    reviewsAllowed: false,
    averageRating: '',
    ratingCount: 0,
    relatedIds: [],
    upsellIds: [],
    crossSellIds: [],
    purchaseNote: '',
    categories: [],
    tags: [],
    images: [],
    attributes: [],
    groupedProducts: [],
    metaData: [],
    availableVariations: [],
    variationOptions: [],
    variationId: '',
    formattedPrice: '',
    formattedSalesPrice: '',
    vendor: Vendor(name: '', icon: ''),
    children: [],
  );
  final ProductDetailBloc productDetailBloc = ProductDetailBloc();

  @override
  void initState() {
    _getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: SizedBox(
          width: 60,
          height: 60,
          child: CachedNetworkImage(
            imageUrl: product.images[0].src,
            imageBuilder: (context, imageProvider) => Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Ink.image(
                // ignore: sort_child_properties_last
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ProductDetail(product: product);
                    }));
                  },
                ),
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            placeholder: (context, url) => Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.black12,
            ),
          ),
        ),
        title: Text(product.name),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("CANCEL"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProductDetail(product: product);
            }));
          },
          child: Text("VIEW"),
          style: ElevatedButton.styleFrom(
            // primary: const Color(0xFF1BC0C5), // Uncomment if you want to set a custom color
          ),
        ),
      ],
    );
    }

  _getProduct() async {
    setState(() {
      loading = true;
    });
    Product newProduct =
    await productDetailBloc.getProductBySKU(widget.result);
    setState(() {
      product = newProduct;
    });
      setState(() {
      loading = false;
    });
  }
}
