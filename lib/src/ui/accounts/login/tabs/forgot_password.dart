//import './../../../../../l10n/gallery_localizations.dart';
// ignore_for_file: library_private_types_in_public_api, avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';

import './../../../../models/app_state_model.dart';
import './../../../../resources/api_provider.dart';
import './../tabs/register_text_form_field.dart';
import '../../../color_override.dart';
import '../../../widgets/buttons/button_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    super.key,
    required this.context,
    required this.model,
    required this.emailController,
    required this.tabController,
  });

  final BuildContext context;
  final AppStateModel model;
  final TextEditingController emailController;
  final TabController tabController;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final apiProvider = ApiProvider();

  //TextEditingController emailController = new TextEditingController();

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
                  height: 150,
                ),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    controller: widget.emailController,
                    label: widget.model.blocks.localeText.email,
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterValidEmail,
                    password: false,
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email, onSaved: (newValue) {  },
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  child: ButtonText(isLoading: isLoading, text: 'Send OTP'),
                  onPressed: isLoading ? null : _sendOtp,
                ),
                SizedBox(height: 12.0),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                    ),
                    onPressed: () {
                      widget.tabController.animateTo(0);
                    },
                    child: Text(
                        widget.model.blocks.localeText.signIn,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                            color:
                            Theme.of(context).colorScheme.secondary))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _sendOtp() async {
    var data = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      data["email"] = widget.emailController.text;
      setState(() {
        isLoading = true;
      });
      final response = await apiProvider.postWithCookies(
          '/wp-admin/admin-ajax.php?action=mstore_flutter-email-otp', data);
      print(response.statusCode);
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        widget.tabController.animateTo(3);
      }
    }
  }
}

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
    required this.context,
    required this.model,
    required this.emailController,
    required this.tabController,
  });

  final BuildContext context;
  final AppStateModel model;
  final TextEditingController emailController;
  final TabController tabController;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final apiProvider = ApiProvider();

  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  PrimaryColorOverride(
                    key:UniqueKey(),
                    child: CustomTextFormField(
                      controller: otpController,
                      label: widget.model.blocks.localeText.otp,
                      validationMsg:
                          widget.model.blocks.localeText.pleaseEnterOtp,
                      password: false,
                      inputType: TextInputType.text,
                      icon: Icons.message, onSaved: (newValue) {  },
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  PrimaryColorOverride(
                    key:UniqueKey(),
                    child: CustomTextFormField(
                      controller: newPasswordController,
                      label: widget.model.blocks.localeText.newPassword,
                      validationMsg:
                          widget.model.blocks.localeText.pleaseEnterPassword,
                      password: true,
                      inputType: TextInputType.text,
                      icon: Icons.vpn_key, onSaved: (newValue) {  },
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    child: ButtonText(isLoading: isLoading, text: widget.model.blocks.localeText.resetPassword,),
                    onPressed: isLoading ? null : () => _resetPassword(widget.model),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _resetPassword(AppStateModel model) async {
    var data = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      data["email"] = widget.emailController.text;
      data["password"] = newPasswordController.text;
      data["otp"] = otpController.text;
      setState(() {
        isLoading = true;
      });
      print(data);
      final response = await apiProvider.postWithCookies(
          '/wp-admin/admin-ajax.php?action=mstore_flutter-reset-user-password',
          data);
      if (response.statusCode == 200) {
        widget.tabController.animateTo(0);
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
