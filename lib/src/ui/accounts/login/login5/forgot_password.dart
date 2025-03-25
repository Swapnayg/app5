import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import './../../../../models/app_state_model.dart';
import './../../../../models/errors/error.dart';
import './../../../../resources/api_provider.dart';
import './../../../../ui/accounts/login/login5/clipper.dart';
import '../../../../functions.dart';
import '../../../color_override.dart';
import 'theme_override.dart';

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
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ThemeOverride(
      child: Builder(
        builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
          value:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          child: Scaffold(
              body: Builder(
            builder: (context) => Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter:
                        CurvePainter2(color: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter:
                        CurvePainter(color: Theme.of(context).colorScheme.background),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.15,
                        ),
                        Text('Forgot Password !',
                            style:
                                Theme.of(context).textTheme.titleLarge.copyWith(
                                    //color: Colors.white,
                                    fontSize: 32)),
                        Text('Enter valid Email to get an OTP',
                            style: Theme.of(context).textTheme.bodySmall.copyWith(
                                //color: Colors.white,
                                fontSize: 14)),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        PrimaryColorOverride(
                          child: TextFormField(
                            obscureText: false,
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return appStateModel
                                    .blocks.localeText.pleaseEnterValidEmail;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText:
                                    appStateModel.blocks.localeText.email),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        RoundedLoadingButton(
                          color: Theme.of(context).buttonColor,
                          elevation: 0,
                          valueColor: Theme.of(context)
                              .buttonTheme
                              .colorScheme
                              .onPrimary,
                          controller: _btnController,
                          onPressed: () => _sendOtp(context),
                          animateOnTap: false,
                          width: MediaQuery.of(context).size.width - 34,
                          child: Text(appStateModel.blocks.localeText.sendOtp),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 36,
                    left: 16,
                    child: IconButton(
                        icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              //color: Colors.grey.withOpacity(0.5),
                            ),
                            width: 35,
                            height: 35,
                            child: Icon(
                              Icons.arrow_back,
                              size: 18,
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }))
              ],
            ),
          )),
        ),
      ),
    );
  }

  _sendOtp(BuildContext context) async {
    var data = Map<String, dynamic>();
    if (_formKey.currentState.validate()) {
      data["email"] = emailController.text;
      _btnController.start();
      final response = await apiProvider.postWithCookies(
          '/wp-admin/admin-ajax.php?action=mstore_flutter-email-otp', data);
      _btnController.stop();
      if (response.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Material(
                    child: ResetPassword(
                  email: emailController.text,
                ))));
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
    Key key,
    @required this.email,
  }) : super(key: key);

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
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ThemeOverride(
      child: Builder(
        builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
          value:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: Builder(
              builder: (context) => Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter:
                          CurvePainter2(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter: CurvePainter(
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(32),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: height * 0.15,
                          ),
                          Text('Reset Password !',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  .copyWith(
                                      //color: Colors.white,
                                      fontSize: 32)),
                          Text('Reset your password by entering OTP',
                              style:
                                  Theme.of(context).textTheme.bodySmall.copyWith(
                                      //color: Colors.white,
                                      fontSize: 14)),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          PrimaryColorOverride(
                            child: TextFormField(
                              obscureText: false,
                              controller: otpController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return appStateModel
                                      .blocks.localeText.pleaseEnterOtp;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: appStateModel.blocks.localeText.otp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          PrimaryColorOverride(
                            child: TextFormField(
                              obscureText: _obscureText,
                              controller: newPasswordController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return appStateModel
                                      .blocks.localeText.pleaseEnterPassword;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      }),
                                  labelText: appStateModel
                                      .blocks.localeText.newPassword),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          RoundedLoadingButton(
                            color: Theme.of(context).buttonColor,
                            elevation: 0,
                            valueColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme
                                .onPrimary,
                            controller: _btnController,
                            onPressed: () => _resetPassword(context),
                            animateOnTap: false,
                            width: MediaQuery.of(context).size.width - 34,
                            child: Text(
                                appStateModel.blocks.localeText.resetPassword),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 36,
                      left: 16,
                      child: IconButton(
                          icon: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                //color: Colors.grey.withOpacity(0.5),
                              ),
                              width: 35,
                              height: 35,
                              child: Icon(
                                Icons.arrow_back,
                                size: 18,
                              )),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _resetPassword(BuildContext context) async {
    var data = <String, dynamic>{};
    if (_formKey.currentState.validate()) {
      data["email"] = widget.email;
      data["password"] = newPasswordController.text;
      data["otp"] = otpController.text;
      _btnController.start();
      final response = await apiProvider.postWithCookies(
          '/wp-admin/admin-ajax.php?action=mstore_flutter-reset-user-password',
          data);
      _btnController.stop();
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
