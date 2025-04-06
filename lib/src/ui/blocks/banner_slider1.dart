// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../models/blocks_model.dart';
import 'hex_color.dart';
import 'list_header.dart';

class BannerSlider1 extends StatefulWidget {
  final Block block;
  final Function onBannerClick;
  const BannerSlider1({super.key, required this.block, required this.onBannerClick});
  @override
  _BannerSlider1State createState() => _BannerSlider1State();
}

class _BannerSlider1State extends State<BannerSlider1> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = HexColor(widget.block.bgColor);
    return SliverPadding(
      padding: EdgeInsets.all(0.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            ListHeader(block: widget.block),
            Container(
              color: Theme.of(context).brightness != Brightness.dark ?  bgColor : Theme.of(context).canvasColor,
              height: widget.block.childHeight.toDouble(),
              padding: EdgeInsets.fromLTRB(double.parse(widget.block.paddingLeft.toString()),
                0.0,
                double.parse(widget.block.paddingRight
                    .toString()),
                double.parse(widget.block.paddingBottom
                    .toString()),
              ),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: HexColor(widget.block.bgColor).withOpacity(0.1),
                    onTap: () => widget.onBannerClick(widget.block.children[index]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(widget.block.borderRadius)),
                      ),
                      elevation: widget.block.elevation.toDouble(),
                      clipBehavior: Clip.antiAlias,
                      child:  CachedNetworkImage(
                        imageUrl: widget.block.children[index].image ?? '',
                        imageBuilder: (context, imageProvider) => Ink.image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          child: InkWell(
                            splashColor: HexColor(widget.block.bgColor).withOpacity(0.1),
                            onTap: () => widget.onBannerClick(widget.block.children[index]),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Container(color: Colors.black12),
                        errorWidget: (context, url, error) => Container(color: Colors.black12),
                      ),
                    ),
                  );
                },
                itemCount: widget.block.children.length,
                pagination: SwiperPagination(),
                autoplay: true,
                containerHeight: widget.block.childHeight,
                viewportFraction: 0.8,
                scale: 0.9,
              ),
            )
          ],
        ),
      ),
    );
  }
}
