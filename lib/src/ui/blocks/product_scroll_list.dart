// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../products/product_grid/products_scroll.dart';
import '../../models/blocks_model.dart';
import 'count_down.dart';
import 'hex_color.dart';
import 'list_header.dart';

class ProductScrollList extends StatefulWidget {
  final Block block;
  final Function onProductClick;
  const ProductScrollList({super.key, required this.block, required this.onProductClick});
  @override
  _ProductScrollListState createState() => _ProductScrollListState();
}

class _ProductScrollListState extends State<ProductScrollList> {
  @override
  Widget build(BuildContext context) {
    if (widget.block.headerAlign != 'left_floating') {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            ListHeader(block: widget.block),
            Container(
                height: (250 + widget.block.paddingBottom).toDouble(),
                margin: EdgeInsets.fromLTRB(
                    double.parse(widget.block.marginLeft.toString()),
                    double.parse(widget.block.marginTop.toString()),
                    double.parse(widget.block.marginRight.toString()),
                    double.parse(widget.block.marginBottom.toString())),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness != Brightness.dark
                      ? HexColor(widget.block.bgColor)
                      : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                        double.parse(widget.block.paddingLeft.toString()),
                        0.0,
                        double.parse(widget.block.paddingRight.toString()),
                        double.parse(widget.block.paddingBottom.toString())),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.block.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      double paddingLeft = widget.block.paddingBetween / 2;
                      double paddingRight = widget.block.paddingBetween / 2;
                      if (index == 0) {
                        paddingLeft = widget.block.paddingBetween;
                      }
                      if (index == widget.block.products.length - 1) {
                        paddingRight = widget.block.paddingBetween;
                      }
                      return Container(
                          margin: EdgeInsets.fromLTRB(
                              paddingLeft, 0.0, paddingRight, 0.0),
                          width:
                              double.parse(widget.block.childWidth.toString()),
                          child: ProductScrollItem(
                            product: widget.block.products[index],
                          ));
                    })),
          ],
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
                height: (280 + widget.block.paddingBottom).toDouble(),
                margin: EdgeInsets.fromLTRB(
                    double.parse(widget.block.marginLeft.toString()),
                    double.parse(widget.block.marginTop.toString()),
                    double.parse(widget.block.marginRight.toString()),
                    double.parse(widget.block.marginBottom.toString())),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness != Brightness.dark
                      ? HexColor(widget.block.bgColor)
                      : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: widget.block.childHeight / 2,
                      left: 20,
                      child: _stackHeader(),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                            double.parse(widget.block.paddingLeft.toString()),
                            double.parse(widget.block.paddingTop.toString()),
                            double.parse(widget.block.paddingRight.toString()),
                            double.parse(
                                widget.block.paddingBottom.toString())),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.block.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          double paddingLeft = widget.block.paddingBetween / 2;
                          double paddingRight = widget.block.paddingBetween / 2;
                          if (index == 0) {
                            paddingLeft = widget.block.paddingBetween;
                          }
                          if (index == widget.block.products.length - 1) {
                            paddingRight = widget.block.paddingBetween;
                          }
                          return Container(
                              margin: EdgeInsets.fromLTRB(
                                  paddingLeft, 0.0, paddingRight, 0.0),
                              width: double.parse(
                                  widget.block.childWidth.toString()),
                              child: ProductScrollItem(
                                product: widget.block.products[index],
                              ));
                        }),
                  ],
                )),
          ],
        ),
      );
    }
  }

  Widget _stackHeader() {
    Color bgColor = HexColor(widget.block.bgColor);
    TextStyle? subhead = Theme.of(context).brightness != Brightness.dark
        ? Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: HexColor(widget.block.titleColor))
        : Theme.of(context).textTheme.titleLarge;

    TextStyle textStyleCounter = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: bgColor, fontSize: 12);

    if (widget.block.blockType == 'flash_sale_block') {
      var dateTo = DateFormat('M/d/yyyy mm:ss').parse(widget.block.saleEnds);
      var dateFrom = DateTime.now();
      final difference = dateTo.difference(dateFrom).inSeconds;

      if (difference.isNegative) {
        return Container();
      } else {
        return Countdown(
          duration: Duration(seconds: difference),
          builder: (BuildContext ctx, Duration remaining) {
            return Column(
              mainAxisAlignment: widget.block.headerAlign == 'top_center'
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  widget.block.title,
                  textAlign: TextAlign.start,
                  style: subhead,
                )),
                Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: HexColor(widget.block.titleColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                        margin: EdgeInsets.all(4),
                        child: Center(
                            child: Text('${remaining.inHours.clamp(0, 99)}',
                                maxLines: 1, style: textStyleCounter)),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: HexColor(widget.block.titleColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                        child: Center(
                            child: Text(
                                '${remaining.inMinutes.remainder(60)}',
                                style: textStyleCounter)),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: HexColor(widget.block.titleColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                        margin: EdgeInsets.all(4),
                        child: Center(
                            child: Text(
                                '${remaining.inSeconds.remainder(60)}',
                                style: textStyleCounter)),
                      ),
                    ]),
              ],
            );
          }, onFinish: () {  },
        );
      }
    } else {
      return Container(
          color: Theme.of(context).brightness != Brightness.dark
              ? bgColor
              : Theme.of(context).canvasColor,
          child: Text(
            widget.block.title,
            textAlign: TextAlign.start,
            style: subhead,
          ));
    }
  }
}
