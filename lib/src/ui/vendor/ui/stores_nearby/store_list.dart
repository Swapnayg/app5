
// ignore_for_file: library_private_types_in_public_api, unused_field, unnecessary_null_comparison

import '../../../../blocs/vendor/vendor_detail_state_model.dart';
import '../../../../functions.dart';

import '../../../../models/app_state_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../models/vendor/store_model.dart';
import './../../ui/products/vendor_detail/vendor_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

const double _scaffoldPadding = 10.0;
const double _minWidthPerColumn = 350.0 + _scaffoldPadding * 2;

class StoresList extends StatelessWidget {
  final List<StoreModel> stores;
  const StoresList({required Key key, required this.stores}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < _minWidthPerColumn
        ? 1
        : screenWidth ~/ _minWidthPerColumn;
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 3,
          crossAxisCount: crossAxisCount,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return StoreCard(key: ValueKey(index), store: stores[index], index: index);
          },
          childCount: stores.length,
        ),
      ),
    );
  }
}

class StoreCard extends StatefulWidget {
  final VendorDetailStateModel vendorDetailModel = VendorDetailStateModel();
  final StoreModel store;
  final int index;
  StoreCard({required Key key, required this.store, required this.index}) : super(key: key);

  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {

  AppStateModel appStateModel = AppStateModel();

  final ScrollController _homeScrollController = ScrollController();

  final ScrollController _allProductsScrollController = ScrollController();

  final ScrollController _vendorDetailScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    Widget featuredImage = widget.store.icon != null
        ? CachedNetworkImage(
      imageUrl: widget.store.icon,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
        ),
      ),

      placeholder: (context, url) => Container(color: Colors.white),
      errorWidget: (context, url, error) => Container(color: Colors.white),
    )
        : Container();

    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openDetails(widget.store, context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 140,
              width: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: featuredImage),
              ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16,8,16,0),
                child: SizedBox(
                  height: 140,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.store.name,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18)),
                        SizedBox(height: 3,),
                        widget.store.description != null ? Text(parseHtmlString((widget.store.description)),
                            //widget.store.address.city,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall) : Container(),
                        SizedBox(height: 2,),
                        widget.store.address!.city != null ? Text(widget.store.address!.city,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            )) : Container(),
                        SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, size: 18, color: Colors.red,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(widget.store.averageRating.toString(),
                            //widget.store.address.city,
                            style: TextStyle(
                              //fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            )),
                      ],
                    )
                      ]),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }


  openDetails(StoreModel store, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return VendorDetails(
        key: ValueKey(store.id),
        vendorId: store.id.toString(),
      );
    }));
  }
}
