// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import './../../../widgets/buttons/button.dart';

import './../../../../models/app_state_model.dart';
import './../../../color_override.dart';
import './../../login/social/apple_login.dart';
import './../../login/social/google_login.dart';
import './../../login/social/sms_login.dart';
import '../../../widgets/buttons/button_text.dart';

class LoginTab extends StatefulWidget {

  LoginTab({super.key, required this.context,
    required this.model,
    required this.tabController,});

  final BuildContext context;
  final AppStateModel model;
  final TabController tabController;
  final appStateModel = AppStateModel();
  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {


  late bool _obscureText;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          SizedBox(height: 16.0),
          Container(
            margin: const EdgeInsets.only(left: 24.0, right: 24.0),
            child:  Form(
              key: _formKey,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 120, maxWidth: 220),
                      child: Image.asset(
                        'lib/assets/images/logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,),
                  PrimaryColorOverride(
                    key:UniqueKey(),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return widget.model.blocks.localeText.pleaseEnterUsername;
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: widget.model.blocks.localeText.username),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 12,),
                  PrimaryColorOverride(
                    key:UniqueKey(),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return widget.model.blocks.localeText.pleaseEnterPassword;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              }
                          ),
                          labelText: widget.model.blocks.localeText.password),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  AccentButton(
                    onPressed: () => _login(context),
                    text: widget.model.blocks.localeText.signIn,
                    showProgress: isLoading,
                  ),
                  SizedBox(height: 12.0),
                  TextButton(
                      onPressed: () {
                        widget.tabController.animateTo(2);
                      },
                      child: Text(
                          widget.model.blocks.localeText.forgotPassword,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              color: Colors.grey
                          ))),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(16.0),
                      ),
                      onPressed: () {
                        widget.tabController.animateTo(1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              widget.model.blocks.localeText
                                  .dontHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.grey
                              )),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                                widget.model.blocks.localeText.signUp,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color:
                                    Theme.of(context).colorScheme.secondary)),
                          ),
                        ],
                      )),
                 
                ],
              ),
            ),
          ),
        ]);
  }

  SizedBox buildIcon(child) {
    return SizedBox(
      width: 30,
      height: 30,
      child: child,
    );
  }
  _login(BuildContext context) async {
    var login = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      login["username"] = usernameController.text;
      login["password"] = passwordController.text;
      setState(() {
        isLoading = true;
      });
      bool status = await widget.model.login(login, context);
      setState(() {
        isLoading = false;
      });
      if (status) {
        Navigator.of(widget.context).pop();
      }
    }
  }

}

class CustomTextFormField extends StatelessWidget {
  bool password;
  bool obscureText;
  IconButton suffix;
  String label;
  String validationMsg;
  TextEditingController controller;
  IconData icon;
  TextInputType inputType;

  CustomTextFormField(
      {super.key, required this.label,
        required this.validationMsg,
        required this.controller,
        required this.icon,
        required this.obscureText,
        required this.inputType,
        required this.password,
        required this.suffix,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
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