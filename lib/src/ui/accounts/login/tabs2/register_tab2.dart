// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, sort_child_properties_last, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';

import './../../../../models/app_state_model.dart';
import './../../../../models/register_model.dart';
import './../../login/social/apple_login.dart';
import './../../login/social/google_login.dart';
import './../../login/social/sms_login.dart';
import '../../../widgets/buttons/button_text.dart';

class RegisterTab extends StatefulWidget {

  RegisterTab({super.key, required this.context,
    required this.model,
    required this.tabController,});

  final BuildContext context;
  final AppStateModel model;
  final TabController tabController;
  final appStateModel = AppStateModel();
  @override
  _RegisterTabState createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  //Country _selected = Country.IN;
  Map loginData =  <String, dynamic>{};
  late bool _obscureText;
  String radioItem = '';
  final _register = RegisterModel(
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    password: '',
    username: '',
    companyName: '',
  );
  var isLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
        //shrinkWrap: true,
        children: [
          SizedBox(height: 15.0),
          Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child:  Form(
              key: _formKey,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 220,
                    constraints: BoxConstraints(minWidth: 120, maxWidth: 120),
                    child: Image.asset(
                      'lib/assets/images/logo.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildIcon(Icon(Icons.person,color: Colors.grey.withOpacity(.6),)),
                      SizedBox(width: 20,),
                      Flexible(
                          child: CustomTextFormField(
                          obscureText: false,
                          label: widget.model.blocks.localeText.firstName,
                          onSaved: (val) =>
                              setState(() => _register.firstName = val),
                          validationMsg: widget
                              .model.blocks.localeText.pleaseEnterFirstName,
                          password: false,
                          inputType: TextInputType.text,
                          prefix: IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {},
                          ),
                          suffix: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          controller: TextEditingController(),
                          icon: Icons.person,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Flexible(
                        child: CustomTextFormField(
                          obscureText: false,
                          label: widget.model.blocks.localeText.lastName,
                          onSaved: (val) =>
                              setState(() => _register.lastName = val),
                          validationMsg: widget
                              .model.blocks.localeText.pleaseEnterLastName,
                          password: false,
                          inputType: TextInputType.text,
                          prefix: IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {},
                          ),
                          suffix: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          controller: TextEditingController(),
                          icon: Icons.person,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildIcon(Icon(Icons.email,color: Colors.grey.withOpacity(.6),)),
                      SizedBox(width: 20,),
                      Flexible(
                          child: CustomTextFormField(
                            obscureText: false,
                            label: widget.model.blocks.localeText.email,
                            onSaved: (val) =>
                                setState(() => _register.email = val),
                            validationMsg: widget
                                .model.blocks.localeText.pleaseEnterValidEmail,
                            password: false,
                            inputType: TextInputType.emailAddress,
                            prefix: IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {},
                          ),
                          suffix: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          controller: TextEditingController(),
                          icon: Icons.person,
                          )
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildIcon(Icon(Icons.lock,color: Colors.grey.withOpacity(.6),)),
                      SizedBox(width: 20,),
                      Flexible(
                        child: CustomTextFormField(
                          obscureText: _obscureText,
                          label: widget.model.blocks.localeText.password,
                          onSaved: (val) =>
                              setState(() => _register.password = val),
                          validationMsg: widget
                              .model.blocks.localeText.pleaseEnterPassword,
                          password: true,
                          suffix: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                              ),
                              color: Colors.grey.withOpacity(.4),
                              onPressed: (){
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              }
                          ),
                          prefix: IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {},
                          ),
                          
                          controller: TextEditingController(),
                          icon: Icons.person,
                          inputType: TextInputType.text,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    child: ButtonText(isLoading: isLoading, text: widget.model.blocks.localeText.signUp),
                    onPressed: isLoading ? null : () => _registerUser(context),
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(fontSize: 15,
                          color: Colors.grey),),
                  ),
                  SizedBox(height: 30.0),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(16.0),
                      ),
                      onPressed: () {
                        widget.tabController.animateTo(0);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              widget.model.blocks.localeText
                                  .alreadyHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.grey)),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                                widget.model.blocks.localeText.signIn,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color:
                                    Theme.of(context).colorScheme.secondary)),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ]);
  }

  Future _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      bool status =
      await widget.model.register(_register.toJson(), context);
      setState(() {
        isLoading = false;
      });
      if (status) {
        Navigator.of(context).pop();
      }
    }
  }

  SizedBox buildIcon(child) {
    return SizedBox(
      width: 30,
      height: 30,
      child: child,
    );
  }

  void onLogin() async {
    print(loginData);
  }

  countrySelector() {
    /*return CountryPicker(
      dense: false,
      showFlag: false,  //displays flag, true by default
      showDialingCode: false, //displays dialing code, false by default
      showName: true, //displays country name, true by default
      showCurrency: true, //eg. 'British pound'
      showCurrencyISO: true, //eg. 'GBP'
      onChanged: (Country country) {
        setState(() {
          _selected = country;
        });
      },
      selectedCountry: _selected,
    );*/
  }
}
class CustomTextFormField extends StatelessWidget {
  bool password;
  bool obscureText;
  IconButton suffix;
  IconButton prefix;
  String label;
  String validationMsg;
  TextEditingController controller;
  IconData icon;
  TextInputType inputType;
  FormFieldSetter onSaved;

  CustomTextFormField(
      {super.key, required this.label,
        required this.prefix,
        required this.validationMsg,
        required this.controller,
        required this.icon,
        required this.obscureText,
        required this.inputType,
        required this.password,
        required this.suffix,
        required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty) {
          return validationMsg;
        }
        return null;
      },
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(.4)),
          ),
          prefixIcon: prefix,
          suffixIcon: suffix,
          labelText: label,
          labelStyle: TextStyle(
              fontFamily: 'Monteserrat',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey.withOpacity(.4)
          ),),
      keyboardType: inputType,
    );
  }
}