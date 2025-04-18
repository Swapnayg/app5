// ignore_for_file: prefer_typing_uninitialized_variables, use_super_parameters, library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../models/app_state_model.dart';
import '../../../../models/orders_model.dart';
import 'order_detail.dart';

class VendorOrderList extends StatefulWidget {
 final vendorBloc = VendorBloc();
 final vendorId;
 final appStateModel = AppStateModel();
  VendorOrderList({Key? key, this.vendorId}) : super(key: key);
  @override
  _VendorOrderListState createState() => _VendorOrderListState();
}

class _VendorOrderListState extends State<VendorOrderList> {
  final ScrollController _scrollController = ScrollController();
  bool hasMoreOrder = true;

  @override
  void initState() {
    super.initState();
    widget.vendorBloc.orderFilter['vendor'] = widget.vendorId;
    widget.vendorBloc.getOrders();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && hasMoreOrder) {
        hasMoreOrder = await widget.vendorBloc.loadMoreOrders();
        if(!hasMoreOrder) {
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddOrderPage(vendorBloc: widget.vendorBloc))
                  //AddOrder(vendorBloc: widget.vendorBloc)),
            ),
          )*/
        ],
       title: Text("Orders"),
      ),
      body: StreamBuilder(
          stream: widget.vendorBloc.allOrders,
          builder: (context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.hasData) {
              // ignore: prefer_is_empty
              if (snapshot.data?.length == 0) {
                return Center(
                    child: Text(widget.appStateModel.blocks.localeText.noOrders));
              } else {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    buildList(snapshot),
                    buildLoadMore(),
                  ],
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  buildList(AsyncSnapshot<List<Order>> snapshot) {
    var formatter1 = DateFormat('yyyy-MM-dd  hh:mm a');
    return SliverPadding(
      padding: EdgeInsets.all(8.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final NumberFormat formatter = NumberFormat.currency(
                decimalDigits: snapshot.data?[index].decimals,
                locale: Localizations.localeOf(context).toString(),
                name: snapshot.data?[index].currency);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Card(
                elevation: 0.5,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4.0),
                    onTap: () => openDetailPage(snapshot.data ?? [], index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                             Text(
                               "ORDER" '-' +
                                    snapshot.data![index].number.toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),

                             Text(
                                formatter.format(double.parse(
                                  snapshot.data![index].total,
                                )),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(snapshot.data![index].status.toUpperCase(), style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: getColor(snapshot.data![index].status)
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(formatter1
                                  .format(snapshot.data![index].dateCreated)),
                            ],
                          )),
                    ),
                  )),
            );
          },
          childCount: snapshot.data?.length,
        ),
      ),
    );
  }

  openDetailPage(List<Order> data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderDetail(order: data[index], vendorBloc: widget.vendorBloc);
    }));
  }

  buildLoadMore() {
    return SliverPadding(
        padding: EdgeInsets.all(0.0),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
              height: 60,
              child: hasMoreOrder ? Center(child: CircularProgressIndicator()) : Container()),
        ])));
  }

  getColor(String status) {
    switch (status) {
      case 'processing':
        return Colors.green;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.redAccent;
      case 'failed':
        return Colors.redAccent;
      case 'on-hold':
        return Colors.amber;
    }

  }
}
