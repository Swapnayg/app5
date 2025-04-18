// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import './../../../../models/app_state_model.dart';
import './../../../accounts/login/social/apple_login.dart';
import './../../../accounts/login/social/google_login.dart';
import './../../../accounts/login/social/sms_login.dart';
import './../tabs/login_text_form_field.dart';
import '../../../color_override.dart';
import '../../../widgets/buttons/button_text.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({
    super.key,
    required this.context,
    required this.model,
    required this.tabController,
  });

  final BuildContext context;
  final AppStateModel model;
  final TabController tabController;

  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    controller: usernameController,
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    label: widget.model.blocks.localeText.username,
                    password: false,
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterUsername,
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    controller: passwordController,
                    icon: Icons.vpn_key,
                    inputType: TextInputType.text,
                    label: widget.model.blocks.localeText.password,
                    password: true,
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterPassword,
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  child: ButtonText(isLoading: isLoading, text: widget.model.blocks.localeText.signIn),
                  onPressed: isLoading ? null : () => _login(context),
                ),
                SizedBox(height: 12.0),
                TextButton(
                    onPressed: () {
                      widget.tabController.animateTo(2);
                    },
                    child: Text(
                        widget.model.blocks.localeText.forgotPassword,
                        style: Theme.of(context).textTheme.bodyMedium)),
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
                            style: Theme.of(context).textTheme.bodyMedium),
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
      ],
    );
  }

  _login(BuildContext) async {
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



