// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import './../../../../models/app_state_model.dart';
import './../../../../models/errors/error.dart';
import './../../../../resources/api_provider.dart';
import './../../../../ui/widgets/buttons/button.dart';
import '../../../../functions.dart';
import '../../../color_override.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final appStateModel = AppStateModel();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Builder(
          builder: (context) => ListView(children: [
            SizedBox(height: 15.0),
            Container(
              margin: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      height: 16,
                    ),
                    PrimaryColorOverride(
                      key:UniqueKey(),
                      child: TextFormField(
                        obscureText: false,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return appStateModel
                                .blocks.localeText.pleaseEnterValidEmail;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: appStateModel.blocks.localeText.email),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    AccentButton(
                      onPressed: () => _sendOtp(context),
                      text: appStateModel.blocks.localeText.sendOtp,
                      showProgress: isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  _sendOtp(BuildContext context) async {
    var data = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      data["email"] = emailController.text;
      setState(() {
        isLoading = true;
      });
      final response = await apiProvider.postWithCookies(
          '/wp-admin/admin-ajax.php?action=mstore_flutter-email-otp', data);
      if (response.statusCode == 200) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Material(child: ResetPassword(email: emailController.text,))));
      } else if (response.statusCode == 400) {
        WpErrors error = WpErrors.fromJson(json.decode(response.body));
        showSnackBarError(context, parseHtmlString(error.data[0].message));
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
    required this.email,
  });

  final String email;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}
class _ResetPasswordState extends State<ResetPassword> {

  final appStateModel = AppStateModel();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final apiProvider = ApiProvider();
  bool _obscureText = true;

  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) => ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        obscureText: false,
                        controller: otpController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return appStateModel.blocks.localeText.pleaseEnterOtp;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: appStateModel.blocks.localeText.otp,),
                      ),
                    ),
                    PrimaryColorOverride(
                      key:UniqueKey(),
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: newPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return appStateModel.blocks.localeText.pleaseEnterPassword;
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
                            labelText: appStateModel.blocks.localeText.newPassword),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    AccentButton(
                      onPressed: () => _resetPassword(context),
                      text: appStateModel.blocks.localeText.signIn,
                      showProgress: isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _resetPassword(BuildContext context) async {
    var data = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      data["email"] = widget.email;
      data["password"] = newPasswordController.text;
      data["otp"] = otpController.text;
      setState(() {
        isLoading = true;
      });
      final response = await apiProvider.postWithCookies(
          '/wp-admin/admin-ajax.php?action=mstore_flutter-reset-user-password',
          data);
      if (response.statusCode == 200) {
        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      } else {
        WpErrors error = WpErrors.fromJson(json.decode(response.body));
        showSnackBarError(context, parseHtmlString(error.data[0].message));
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}

