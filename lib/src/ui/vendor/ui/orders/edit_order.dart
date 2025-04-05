// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../../blocs/vendor/vendor_bloc.dart';
import '../../../../functions.dart';
import '../../../../models/checkout/checkout_form_model.dart';
import '../../../../models/customer_model.dart';
import '../../../../models/orders_model.dart';
import '../../../../ui/color_override.dart';

class EditOrder extends StatefulWidget {
  final VendorBloc vendorBloc;
  final Order order;

  const EditOrder({Key? key, required this.vendorBloc,required this.order})
      : super(key: key);
  @override
  _EditOrderState createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  final _formKey = GlobalKey<FormState>();
  final billing = Address();
  final shipping = Address();
  late List<Region> regions;

  @override
  void initState() {
    super.initState();
    widget.vendorBloc.getVendorOrderForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order'),
      ),
      body: StreamBuilder<CheckoutFormModel>(
          stream: widget.vendorBloc.vendorOrderForm,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? buildListView(context, snapshot)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

Widget buildListView(BuildContext context, AsyncSnapshot<CheckoutFormModel> snapshot) {

  if(snapshot.data?.countries.indexWhere((country) => country.value == widget.order.billing.country) != -1) {
    regions = snapshot.data!.countries.singleWhere((country) => country.value == widget.order.billing.country).regions;
  } else if(snapshot.data?.countries.indexWhere((country) => country.value == widget.order.billing.country) == -1) {
    widget.order.billing.country = snapshot.data!.countries.first.value;
  } if(regions.isNotEmpty) {
    widget.order.billing.state = regions.any((z) => z.value == widget.order.billing.state) ? widget.order.billing.state
        : regions.first.value;
  }

  return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Billing Details",
                style: TextStyle(fontSize: 20.0),
              ),
              TextFormField(
                initialValue: widget.order.billing.firstName,
                decoration: InputDecoration(
                  labelText: "FirstName",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter firstname";
                  }
                  return null;
                },
                onSaved: (val) =>
                    setState(() =>widget.order.billing.firstName = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.lastName,
                decoration: InputDecoration(labelText: "LastName"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter last name";
                  }
                  return null;
                },
                onSaved: (val) =>
                    setState(() =>widget.order.billing.lastName = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.company,
                decoration: InputDecoration(
                  labelText: "Company",
                ),
                onSaved: (val) =>
                    setState(() =>widget.order.billing.company = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.address1,
                decoration: InputDecoration(
                  labelText: "Address1",
                ),
                onSaved: (val) =>
                    setState(() =>widget.order.billing.address1 = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.address2,
                decoration: InputDecoration(
                  labelText: "Address2",
                ),
                onSaved: (val) =>
                    setState(() =>widget.order.billing.address2 = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.city,
                decoration: InputDecoration(
                  labelText: "City",
                ),
                onSaved: (val) =>
                    setState(() =>widget.order.billing.city = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.postcode,
                decoration: InputDecoration(
                  labelText: "Postcode",
                ),
                onSaved: (val) =>
                    setState(() => widget.order.billing.postcode = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.email,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter email";
                  }
                  return null;
                },
                onSaved: (val) =>
                    setState(() => widget.order.billing.email = val!),
              ),
              TextFormField(
                initialValue:widget.order.billing.phone,
                decoration: InputDecoration(labelText: "Phonenumber"),
                onSaved: (val) =>
                    setState(() =>widget.order.billing.phone = val!),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: widget.order.billing.country,
                hint: Text("Country"),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Theme.of(context).dividerColor,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      widget.order.billing.country = newValue;
                    });
                  }
                },
                items: snapshot.data?.countries
                    .map<DropdownMenuItem<String>>(
                        (value) {
                      return DropdownMenuItem<String>(
                        value: value.value,
                        child: Text(parseHtmlString(value.label)),
                      );
                    }).toList(),
              ),
              (regions.isNotEmpty) ? Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  DropdownButton<String>(
                    value: widget.order.billing.state,
                    hint: Text('state'),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          widget.order.billing.state = newValue;
                        });
                      }
                    },
                    items: regions
                        .map<DropdownMenuItem<String>>(
                            (value) {
                          return DropdownMenuItem<String>(
                            value: value.value,
                            child: Text(parseHtmlString(value.label)),
                          );
                        }).toList(),
                  ),
                ],
              ) : PrimaryColorOverride(
                  key: Key('billing_state_override'),
                child: TextFormField(
                  initialValue: widget.order.billing.state,
                  decoration: InputDecoration(labelText: 'State'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter State";
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() => widget.vendorBloc.formData['billing_state'] = val!),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                "Shipping Details:",
                style: TextStyle(fontSize: 20.0),
              ),
              TextFormField(
                initialValue:widget.order.shipping.firstName,
                decoration: InputDecoration(labelText: "FirstName"),
                onSaved: (val) =>
                    setState(() =>widget.order.shipping.firstName = val!),
              ),
              TextFormField(
                initialValue:widget.order.shipping.lastName,
                decoration: InputDecoration(labelText: "LastName"),
                onSaved: (val) =>
                    setState(() =>widget.order.shipping.lastName = val!),
              ),
              TextFormField(
                initialValue:widget.order.shipping.company,
                decoration: InputDecoration(labelText: "Company"),
                onSaved: (val) =>
                    setState(() =>widget.order.shipping.company = val!),
              ),
              TextFormField(
                initialValue:widget.order.shipping.address1,
                decoration: InputDecoration(labelText: "Address1"),
                onSaved: (val) =>
                    setState(() =>widget.order.shipping.address1 = val!),
              ),
              TextFormField(
                initialValue:widget.order.shipping.address2,
                decoration: InputDecoration(labelText: "Address2"),
                onSaved: (val) =>
                    setState(() =>widget.order.shipping.address2 = val!),
              ),
              TextFormField(
                initialValue:widget.order.shipping.city,
                decoration: InputDecoration(labelText: "City"),
                onSaved: (val) =>
                    setState(() =>widget.order.shipping.city = val!),
              ),
              TextFormField(
                initialValue:widget.order.shipping.postcode,
                decoration: InputDecoration(labelText: "Postcode"),
                onSaved: (val) =>
                    setState(() =>widget.order.shipping.postcode = val!),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: widget.order.billing.country,
                hint: Text('Country'),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Theme.of(context).dividerColor,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      widget.order.billing.country = newValue;
                    });
                  }
                },
                items: snapshot.data?.countries
                    .map<DropdownMenuItem<String>>(
                        (value) {
                      return DropdownMenuItem<String>(
                        value: value.value,
                        child: Text(parseHtmlString(value.label)),
                      );
                    }).toList(),
              ),
              (regions.isNotEmpty) ? Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  DropdownButton<String>(
                    value: widget.order.billing.state,
                    hint: Text('state'),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          widget.order.billing.state = newValue;
                        });
                      }
                    },
                    items: regions
                        .map<DropdownMenuItem<String>>(
                            (value) {
                          return DropdownMenuItem<String>(
                            value: value.value,
                            child: Text(parseHtmlString(value.label)),
                          );
                        }).toList(),
                  ),
                ],
              ) : PrimaryColorOverride(
                key: Key('shipping_state_override'),
                child: TextFormField(
                  initialValue:
                  widget.vendorBloc.formData['billing_state'],
                  decoration: InputDecoration(labelText: "State"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter State";
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() =>
                  widget.vendorBloc.formData['billing_state'] = val!),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        widget.order.shipping.country = '';
                        widget.vendorBloc.editOrder(widget.order);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Submit", textAlign: TextAlign.center),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
