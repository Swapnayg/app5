// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../../../../models/app_state_model.dart';
import './../../../../resources/api_provider.dart';
import '../../../widgets/buttons/button_text.dart';

class ForgotPassword extends StatefulWidget {

  const ForgotPassword({super.key,
    required this.context,
    required this.model,
    required this.tabController,
    required this.emailController,
  });

  final BuildContext context;
  final AppStateModel model;
  final TabController tabController;
  final TextEditingController emailController;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final apiProvider = ApiProvider();


  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          SizedBox(height: 15.0),
          Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child:  Form(
              key: _formKey,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      buildIcon(Icon(Icons.email,color: Colors.grey.withOpacity(.6),)),
                      SizedBox(width: 20,),
                      Flexible(
                          child: CustomTextFormField(
                            controller:  widget.emailController,
                            obscureText: false,
                            inputType: TextInputType.emailAddress,
                            label: widget.model.blocks.localeText.email,
                            validationMsg: widget
                                .model.blocks.localeText.pleaseEnterValidEmail,
                            password: false,
                            suffix: null, icon: Icons.code,
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    child: ButtonText(isLoading: isLoading, text: 'Send OTP'),
                    onPressed: isLoading ? null : _sendOtp,
                  ),
                  SizedBox(height: 12.0),
                  TextButton(
                      onPressed: () {
                        widget.tabController.animateTo(0);
                      },
                      child: Text(
                          widget.model.blocks.localeText.signIn,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color:
                              Theme.of(context).colorScheme.secondary
                          ))),
                ],
              ),
            ),
          ),
        ]);
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

  SizedBox buildIcon(child) {
    return SizedBox(
      width: 30,
      height: 30,
      child: child,
    );
  }

}

class CustomTextFormField extends StatelessWidget {
  bool password;
  bool obscureText;
  IconButton? suffix;
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
      obscureText: password,
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
                     CustomTextFormField(
                      controller: otpController,
                      label: widget.model.blocks.localeText.otp,
                      validationMsg:
                      widget.model.blocks.localeText.pleaseEnterOtp,
                      password: false,
                      inputType: TextInputType.text,
                      icon: Icons.code,
                      obscureText: false, suffix: null,
                    ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  CustomTextFormField(
                      controller: newPasswordController,
                      label: widget.model.blocks.localeText.newPassword,
                      validationMsg:
                      widget.model.blocks.localeText.pleaseEnterPassword,
                      password: true,
                      inputType: TextInputType.text,
                      icon: Icons.vpn_key,
                      obscureText: false, suffix: null,
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
