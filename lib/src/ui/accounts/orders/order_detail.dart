// ignore_for_file: library_private_types_in_public_api, unused_field, unnecessary_null_comparison, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../functions.dart';
import './../../../blocs/orders_bloc.dart';
import './../../../models/app_state_model.dart';
import './../../../models/orders_model.dart';

class OrderDetail extends StatefulWidget {

  AppStateModel appStateModel = AppStateModel();
  final OrdersBloc ordersBloc;
  final Order order;

  OrderDetail({super.key, required this.order, required this.ordersBloc});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {


  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.currency(
        decimalDigits: widget.order.decimals, locale: Localizations.localeOf(context).toString(), name: widget.order.currency);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appStateModel.blocks.localeText.order)
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            buildOrderDetails(context, formatter),
            buildItemDetails(context, formatter),
            buildTotalDetails(context, formatter),
          ],
        ));
  }

  Widget buildOrderDetails(BuildContext context, NumberFormat formatter) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${widget.order.number} - ${getOrderStatusText(widget.order.status, widget.appStateModel.blocks.localeText)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                widget.order.status == 'pending' ? SizedBox(
                  height: 25,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                      ),
                      onPressed: () async {
                        widget.ordersBloc.cancelOrder(widget.order);
                        setState(() {
                          widget.order.status = 'cancelled';
                        });
                      }, 
                      child: Text('Cancel')
                  ),
                ) : Container()
              ],
            ),
            Divider(),
            SizedBox(height: 10.0),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.appStateModel.blocks.localeText.billing.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                      '''${widget.order.billing.firstName} ${widget.order.billing.lastName} ${widget.order.billing.address1} ${widget.order.billing.address2} ${widget.order.billing.city} ${widget.order.billing.country} ${widget.order.billing.postcode}'''),
                ]),
            Divider(),
            SizedBox(height: 10.0),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.appStateModel.blocks.localeText.shipping.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      '''${widget.order.shipping.firstName} ${widget.order.shipping.lastName} ${widget.order.shipping.address1} ${widget.order.shipping.address2} ${widget.order.shipping.city} ${widget.order.shipping.country} ${widget.order.shipping.postcode}'''),
                ]),
            Divider(),
            SizedBox(height: 10.0),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.appStateModel.blocks.localeText.payment.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(widget.order.paymentMethodTitle),
                ]),
            Divider(),
            SizedBox(height: 10.0),
            widget.order.lineItems != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(
                          widget.appStateModel.blocks.localeText.products.toUpperCase(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ])
                : Container(),
          ],
        ),
      )
    ]));
  }

  buildTotalDetails(BuildContext context, NumberFormat formatter) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Divider(),
          SizedBox(height: 10.0),
          Text(
            widget.appStateModel.blocks.localeText.total.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(widget.appStateModel.blocks.localeText.shipping,),
              ),
              Text(formatter.format((double.parse(widget.order.shippingTotal)))),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(widget.appStateModel.blocks.localeText.tax,),
              ),
              Text(formatter.format((double.parse(widget.order.totalTax)))),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(widget.appStateModel.blocks.localeText.discount),
              ),
              Text(formatter.format((double.parse(widget.order.discountTotal)))),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.appStateModel.blocks.localeText.total,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text(
                formatter.format(
                  double.parse(widget.order.total),
                ),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ]),
      )
    ]));
  }

  buildItemDetails(BuildContext context, NumberFormat formatter) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {

            String metaData = '';
            for (var element in widget.order.lineItems[index].metaData) {
              if(element.value is String) {
                metaData = '${element.key}-' + element.value + '.';
              }
            }

            return Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text('${widget.order.lineItems[index].name} x ${widget.order.lineItems[index].quantity}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(formatter.format(
                            (double.parse(widget.order.lineItems[index].total)))),
                      ],
                    )),
              ],
            );
          },
          childCount: widget.order.lineItems.length,
        ),
      ),
    );
  }
}
