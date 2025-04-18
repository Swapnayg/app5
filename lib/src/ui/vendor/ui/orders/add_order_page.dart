// ignore_for_file: library_private_types_in_public_api, sort_child_properties_last, avoid_print, unused_element, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../models/customer_model.dart';
import '../../../../models/orders_model.dart';
import 'add_customer.dart';
import 'add_product.dart';

class AddOrderPage extends StatefulWidget {
  final VendorBloc vendorBloc;
 final order = Order(
   id: 0,
   parentId: 0,
   number: '',
   orderKey: '',
   createdVia: '',
   version: '',
   status: '',
   currency: '',
   dateCreated: DateTime.now(),
   dateCreatedGmt: DateTime.now().toUtc(),
   dateModified: DateTime.now(),
   dateModifiedGmt: DateTime.now().toUtc(),
   discountTotal: '0.0',
   discountTax: '0.0',
   shippingTotal: '0.0',
   shippingTax: '0.0',
   cartTax: '0.0',
   total: '0.0',
   totalTax: '0.0',
   pricesIncludeTax: false,
   customerId: 0,
   customerIpAddress: '',
   customerUserAgent: '',
   customerNote: '',
   billing: Address(
    firstName: '',
    lastName: '',
    company: '',
    address1: '',
    address2: '',
    city: '',
    postcode: '',
    country: '',
    state: '',
    email: '',
    phone: '',
  ),
   shipping: Address(
    firstName: '',
    lastName: '',
    company: '',
    address1: '',
    address2: '',
    city: '',
    postcode: '',
    country: '',
    state: '',
    email: '',
    phone: '',
  ),
   paymentMethod: '',
   paymentMethodTitle: '',
   transactionId: '',
   cartHash: '',
   metaData: [],
   lineItems: [],
   taxLines: [],
   shippingLines: [],
   feeLines: [],
   couponLines: [],
   refunds: [],
   decimals: 2,
 );


  AddOrderPage({super.key, required this.vendorBloc});

  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final TextEditingController _totalController = TextEditingController();

  var qty = 0;

  @override
  void initState() {
    super.initState();
    widget.vendorBloc.fetchAllProducts();
    widget.vendorBloc.getVendorOrderForm();
    widget.order.lineItems = List<LineItem>.empty(growable: true);
    widget.order.billing = Address(
    firstName: '',
    lastName: '',
    company: '',
    address1: '',
    address2: '',
    city: '',
    postcode: '',
    country: '',
    state: '',
    email: '',
    phone: '',
  );
    widget.order.shipping = Address(
    firstName: '',
    lastName: '',
    company: '',
    address1: '',
    address2: '',
    city: '',
    postcode: '',
    country: '',
    state: '',
    email: '',
    phone: '',
  );
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.currency(
        decimalDigits: widget.order.decimals,
        locale: Localizations.localeOf(context).toString(),
        name: widget.order.currency);


    return Scaffold(
        appBar: AppBar(
          title: Text('Add Order'),
        ),
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                buildOrder(context, formatter),
                buildProductDetails(context, formatter),
                // buildCustomerDetails(context, formatter)
              ],
            ),
            Positioned(
              bottom: 20,
              left: 30.0,
              right: 30.0,
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    print(widget.order);

                    if (true) {
                      widget.vendorBloc.addOrder(widget.order); // In new Page

                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ),
          ],
        ));
  }

  buildOrder(BuildContext context, NumberFormat formatter) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCustomer(
                              vendorBloc: widget.vendorBloc,
                              order: widget.order))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.person_add,
                            size: 25,
                          ),
                          iconSize: 20.0,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCustomer(
                                            vendorBloc: widget.vendorBloc,
                                            order: widget.order))),
                              }),
                      Text(
                        'Add Customer',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductList(
                              vendorBloc: widget.vendorBloc,
                              order: widget.order))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            size: 25,
                          ),
                          iconSize: 20.0,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddProductList(
                                            vendorBloc: widget.vendorBloc,
                                            order: widget.order))),
                              }),
                      Text(
                        'Add Product',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ]));
  }

  buildProductDetails(BuildContext context, NumberFormat formatter) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text('${widget.order.lineItems[index].name} x ${widget.order.lineItems[index].quantity}'
                          ),
                        ),
                        Text(formatter.format((double.parse(
                            '${widget.order.lineItems[index].price}')))),

                        IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              print(widget.order.lineItems[index]);
                              setState(() {
                                widget.order.lineItems
                                    .remove(widget.order.lineItems[index]);
                              });
                            })
                      ],
                    ),
                    height: 80),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    /*  SizedBox(
                        width: 120,
                        child: TextFormField(
                          initialValue: formatter.format((double.parse(
                              '${widget.order.lineItems[index].total}'))),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              widget.order.lineItems[index].total =
                                  (double.parse(newValue)).toString();
                            });
                          },
                          // onSaved: (val) => setState(() =>  widget.order.lineItems[index].total = val),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                         initialValue: widget.order.lineItems[index].quantity.toString(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                           suffixIcon: Column(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_drop_up,
                                    ),
                                     onPressed: () => _increaseQty()
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                   onPressed: () => _decreaseQty()
                                  ),
                                ],
                              ),

                          ),
                        ),
                      ),*/

                    ],
                  ),
                  // ),
                ),
              ],
            );
          },
          childCount: widget.order.lineItems.length,
        ),
      ),
    );
  }

  buildCustomerDetails(BuildContext context, NumberFormat formatter) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        padding: EdgeInsets.all(10.0),
        child: InkWell(
          /*  onTap: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditOrder(vendorBloc: widget.vendorBloc)));
          },*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Billing Details:",
                      style: Theme.of(context).textTheme.titleMedium,
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
                      "Shipping Details:",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        '''${widget.order.shipping.firstName} ${widget.order.shipping.lastName} ${widget.order.shipping.address1} ${widget.order.shipping.address2} ${widget.order.shipping.city} ${widget.order.shipping.country} ${widget.order.shipping.postcode}'''),
                  ]),
            ],
          ),
        ),
      )
    ]));
  }



  void _increaseQty() {
  if(widget.order.lineItems != 0){
    setState(() {
      qty = qty + 1;
    });
  }
  }




  void _decreaseQty() {

  }

}
