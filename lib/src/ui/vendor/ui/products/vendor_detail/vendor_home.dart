
// ignore_for_file: use_super_parameters, library_private_types_in_public_api, unnecessary_null_comparison, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../../../models/app_state_model.dart';
import '../../../../../ui/products/product_grid/products_scroll.dart';

import '../../../../../blocs/vendor/vendor_detail_state_model.dart';
import '../../../../../models/blocks_model.dart' hide Image, Key, Theme;
import '../../../../../models/category_model.dart';
import '../../../../../models/product_model.dart';
import '../../../../../models/vendor/vendor_details_model.dart';
import '../../../../../ui/blocks/banner_grid_list.dart';
import '../../../../../ui/blocks/banner_scroll_list.dart';
import '../../../../../ui/blocks/banner_slider.dart';
import '../../../../../ui/blocks/banner_slider1.dart';
import '../../../../../ui/blocks/banner_slider2.dart';
import '../../../../../ui/blocks/banner_slider3.dart';
import '../../../../../ui/blocks/product_grid_list.dart';
import '../../../../../ui/blocks/product_scroll_list.dart';
import '../../../../../ui/blocks/vendor_category_grid_list.dart';
import '../../../../../ui/blocks/vendor_category_scroll_list.dart';
import '../../../../../ui/products/product_detail/product_detail.dart';
import '../../../../../ui/products/product_grid/product_item4.dart';
import '../../../../../ui/products/products.dart';
import '../../../../../models/product_model.dart' as variation_model;

class VendorHome extends StatefulWidget {
  final VendorDetailStateModel vendorDetailsModel;
  final ScrollController homeScrollController;
  const VendorHome({Key? key, required this.vendorDetailsModel, required this.homeScrollController})
      : super(key: key);

  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  //ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    widget.homeScrollController.addListener(() async {
      if (widget.homeScrollController.position.pixels ==
          widget.homeScrollController.position.maxScrollExtent) {
        widget.vendorDetailsModel.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: () async {
      widget.vendorDetailsModel.getDetails();
      return;
    }, child: ScopedModelDescendant<VendorDetailStateModel>(
        builder: (context, child, model) {
      return model.vendorDetails != null
          ? Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Color(0xFFf2f3f7)
                  : Colors.black,
              child: CustomScrollView(
                controller: widget.homeScrollController,
                slivers: buildLisOfBlocks(model.vendorDetails),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    }));
  }

  List<Widget> buildLisOfBlocks(VendorDetailsModel vendorDetails) {
    List<Widget> list = [];

    for (var i = 0; i < vendorDetails.blocks.length; i++) {
      if (vendorDetails.blocks[i].blockType == 'banner_block' &&
          vendorDetails.blocks[i].children.length != 0) {
        if (vendorDetails.blocks[i].style == 'grid') {
          // list.add(buildGridHeader(snapshot, i));
          list.add(BannerGridList(
              block: vendorDetails.blocks[i], onBannerClick: onBannerClick));
        }

        if (vendorDetails.blocks[i].style == 'scroll') {
          list.add(BannerScrollList(
              block: vendorDetails.blocks[i], onBannerClick: onBannerClick));
        }

        if (vendorDetails.blocks[i].style == 'slider') {
          list.add(BannerSlider(
              block: vendorDetails.blocks[i], onBannerClick: onBannerClick));
        }

        if (vendorDetails.blocks[i].style == 'slider1') {
          list.add(BannerSlider1(
              block: vendorDetails.blocks[i], onBannerClick: onBannerClick));
        }

        if (vendorDetails.blocks[i].style == 'slider2') {
          list.add(BannerSlider2(
              block: vendorDetails.blocks[i], onBannerClick: onBannerClick));
        }

        if (vendorDetails.blocks[i].style == 'slider3') {
          list.add(BannerSlider3(
              block: vendorDetails.blocks[i], onBannerClick: onBannerClick));
        }
      }

      if (vendorDetails.blocks[i].blockType == 'product_block' &&
          vendorDetails.blocks[i].style == 'scroll' &&
          vendorDetails.blocks[i].products.length != 0) {
        var filter = <String, dynamic>{};
        filter[vendorDetails.blocks[i].filterBy] = '1';
        list.add(ProductScroll(products: vendorDetails.blocks[i].products, context: context, title: vendorDetails.blocks[i].title, viewAllTitle: AppStateModel().blocks.localeText.viewAll, filter: filter));
      }

      if (vendorDetails.blocks[i].blockType == 'product_block' &&
          vendorDetails.blocks[i].style == 'grid') {
        //list.add(buildGridHeader(vendorDetails.blocks[i], i));
        list.add(ProductGridList(
            block: vendorDetails.blocks[i], onProductClick: onProductClick));
      }

      if (vendorDetails.blocks[i].blockType == 'category_block' &&
          vendorDetails.blocks[i].style == 'scroll') {
        if (vendorDetails.blocks[i].borderRadius == 50) {
          list.add(VendorCategoryScrollStadiumList(
              block: vendorDetails.blocks[i],
              categories: vendorDetails.blocks[i].categories,
              onCategoryClick: onCategoryClick));
        } else {
          list.add(VendorCategoryScrollList(
              block: vendorDetails.blocks[i],
              categories: vendorDetails.blocks[i].categories,
              onCategoryClick: onCategoryClick));
        }
      }

      if (vendorDetails.blocks[i].blockType == 'category_block' &&
          vendorDetails.blocks[i].style == 'grid') {
        //list.add(buildGridHeader(vendorDetails.blocks[i], i));
        if (vendorDetails.blocks[i].borderRadius == 50) {
          list.add(VendorCategoryStadiumGridList(
              block: vendorDetails.blocks[i],
              categories: vendorDetails.blocks[i].categories,
              onCategoryClick: onCategoryClick));
        } else {
          list.add(VendorCategoryGridList(
              block: vendorDetails.blocks[i],
              categories: vendorDetails.blocks[i].categories,
              onCategoryClick: onCategoryClick));
        }
      }
    }

    if (vendorDetails.recentProducts != null) {
      list.add(ProductGrid(products: vendorDetails.recentProducts));

      list.add(SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            ScopedModelDescendant<VendorDetailStateModel>(
                builder: (context, child, model) {
              return model.hasMoreItems
                  ? SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator()))
                  : Container();
            })
          ]))));
    }

    return list;
  }

  double? _headerAlign(String align) {
    switch (align) {
      case 'top_left':
        return -1;
      case 'top_right':
        return 1;
      case 'top_center':
        return 0;
      case 'floating':
        return 2;
      case 'none':
        return null;
      default:
        return -1;
    }
  }

  Widget buildGridHeader(Block block, int childIndex) {
    double? textAlign = _headerAlign(block.headerAlign);
    TextStyle subhead = Theme.of(context).brightness != Brightness.dark
        ? Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600, color: HexColor(block.titleColor))
        : Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600);
    return textAlign != null
        ? SliverToBoxAdapter(
            child: Container(
                padding: EdgeInsets.fromLTRB(
                    double.parse(block.paddingLeft.toString()) + 4,
                    double.parse(block.paddingTop.toString()),
                    double.parse(block.paddingRight.toString()) + 4,
                    16.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                alignment: Alignment(textAlign, 0),
                child: Text(
                  block.title,
                  textAlign: TextAlign.start,
                  style: subhead,
                )))
        : SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  block.paddingBetween,
                  double.parse(block.paddingTop.toString()),
                  block.paddingBetween,
                  0.0),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          );
  }

  Widget buildRecentProductGridList(VendorDetailsModel snapshot) {
    return ProductGrid(products: snapshot.recentProducts);
  }

  onProductClick(product) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductDetail(product: product);
    }));
  }

  onBannerClick(Child data) {
    //Naviaget yo product or product list depend on type
    if (data.url.isNotEmpty) {
      if (data.description == 'category') {
        var filter = <String, dynamic>{};
        filter['id'] = data.url;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductsWidget(filter: filter, name: data.title)));
      }
      if (data.description == 'product') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                      product: Product(
                        id: int.parse(data.url),
                        name: data.title,
                        type: '', // Provide appropriate value
                        status: '', // Provide appropriate value
                        featured: false, // Provide appropriate value
                        catalogVisibility: '', // Provide appropriate value
                        description: '', // Provide appropriate value
                        shortDescription: '', // Provide appropriate value
                        permalink: '', // Provide appropriate value
                        sku: '', // Provide appropriate value
                        price: 0, // Provide appropriate value
                        regularPrice: 0, // Provide appropriate value
                        salePrice: 0, // Provide appropriate value
                        onSale: false, // Provide appropriate value
                        purchasable: false, // Provide appropriate value
                        totalSales: 0, // Provide appropriate value
                        virtual: false, // Provide appropriate value
                        downloadable: false, // Provide appropriate value
                        externalUrl: '', // Provide appropriate value
                        buttonText: '', // Provide appropriate value
                        manageStock: false, // Provide appropriate value
                        stockQuantity: 0, // Provide appropriate value
                        stockStatus: '', // Provide appropriate value
                        backorders: '', // Provide appropriate value
                        backordersAllowed: false, // Provide appropriate value
                        backordered: false, // Provide appropriate value
                        soldIndividually: false, // Provide appropriate value
                        weight: '', // Provide appropriate value
                        dimensions: variation_model.Dimensions(length: '', width: '', height: ''), // Provide appropriate value
                        reviewsAllowed: false, // Provide appropriate value
                        averageRating: '', // Provide appropriate value
                        ratingCount: 0, // Provide appropriate value
                        relatedIds: [], // Provide appropriate value
                        upsellIds: [], // Provide appropriate value
                        crossSellIds: [], // Provide appropriate value
                        purchaseNote: '', // Provide appropriate value
                        categories: [], // Provide appropriate value
                        tags: [], // Provide appropriate value
                        images: [], // Provide appropriate value
                        attributes: [], // Provide appropriate value
                        groupedProducts: [], // Provide appropriate value
                        metaData: [], // Provide appropriate value
                        availableVariations: [], // Provide appropriate value
                        variationOptions: [], // Provide appropriate value
                        variationId: '', // Provide appropriate value
                        formattedPrice: '', // Provide appropriate value
                        formattedSalesPrice: '', // Provide appropriate value
                        vendor: Vendor(name: '', icon: ''), // Provide appropriate value
                        children: [], // Provide appropriate value
                      ),
                    )));
      }
    }
  }

  onCategoryClick(Category category, List<Category> categories) {
    var filter = <String, dynamic>{};
    filter['id'] = category.id.toString();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProductsWidget(filter: filter, name: category.name)));
  }

  Widget buildFeaturedGridList(BlocksModel snapshot) {
    return ProductFeaturedGrid(products: snapshot.featured);
  }

  Widget buildOnSaleList(BlocksModel snapshot) {
    return ProductOnSale(products: snapshot.onSale, title: 'On Sale');
  }

  Widget ProductOnSale({required List<Product> products, required String title}) {
    if (products.length > 0) {
      return Container(
        child: SliverList(
          delegate: SliverChildListDelegate(
            [
              products.length != null
                  ? Container(
                      height: 20,
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text('On Sale',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w800)))
                  : Container(),
              Container(
                  height: 310,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
                  decoration: BoxDecoration(
                      //color: Colors.pink,
                      ),
                  child: ListView.builder(
                      padding: EdgeInsets.all(12.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            width: 200,
                            child: ProductItem(
                                product: products[index]));
                      })),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: SliverToBoxAdapter(),
      );
    }
  }

  Widget ProductFeaturedGrid({required List<Product> products}) {
    if (products.length > 0) {
      return Container(
        child: SliverList(
          delegate: SliverChildListDelegate(
            [
              products.length != null
                  ? Container(
                      height: 20,
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text('Featured',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              )))
                  : Container(),
              Container(
                  height: 310,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 14.0),
                  decoration: BoxDecoration(
                      //color: Colors.pink,
                      ),
                  child: ListView.builder(
                      padding: EdgeInsets.all(12.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            width: 200,
                            child: ProductItem(
                                product: products[index]));
                      })),
            ],
          ),
        ),
      );
    } else {
      return Container(
        child: SliverToBoxAdapter(),
      );
    }
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
