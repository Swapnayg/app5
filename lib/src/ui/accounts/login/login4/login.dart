// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unused_element, curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import './../../../../models/app_state_model.dart';
import './../../../../ui/accounts/login/login4/style.dart';
import './../../../../ui/accounts/login/social/apple_login.dart';
import './../../../../ui/accounts/login/social/google_login.dart';
import './../../../../ui/accounts/login/social/sms_login.dart';
import './../../../../ui/widgets/buttons/button.dart';
import '../../../color_override.dart';
import 'forgot_password.dart';
import 'phone_number.dart';
import 'register.dart';


class Login4 extends StatefulWidget {
  const Login4({super.key});

  @override
  _Login4State createState() => _Login4State();
}

class _Login4State extends State<Login4> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final appStateModel = AppStateModel();
  bool _obscureText = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00363a),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Builder(
            builder: (context) =>
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: Theme.of(context).brightness != Brightness.dark ?
                  BoxDecoration(
                    gradient:
                    LinearGradient(
                        stops: [0.6, 1],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF00363a), Color(0xFF006064)]),):
                  BoxDecoration(
                      color: Colors.black
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                      shrinkWrap: true,
                    children: [
                      Form(
                        key: _formKey,
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                icon: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      //color: Colors.grey.withOpacity(0.5),
                                    ),
                                    width: 35,
                                    height: 35,
                                    child: Icon(Icons.arrow_back, color: Colors.white, size: 22,)
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            Row(
                              crossAxisAlignment:CrossAxisAlignment.start ,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:30, left: 10),
                                  child: RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 38,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only( top:30, left: 20.0),
                                  child: SizedBox(
                                    height: 140,
                                    width: 180,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 16,),
                                        Center(
                                          child: Text(
                                            'Sign in to your account',
                                            style: TextStyle(
                                              fontSize: 28,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,),
                            Padding(
                              padding: const EdgeInsets.only(left:24.0, right: 24),
                              child: PrimaryColorOverride(
                                key:UniqueKey(),
                                child: TextFormField(
                                  style: textStyle,
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appStateModel.blocks.localeText.pleaseEnterUsername;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: errorStyle,
                                      labelStyle: labelStyle,
                                      border: InputBorder.none,
                                      labelText: appStateModel.blocks.localeText.username),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,),
                            Padding(
                                padding: const EdgeInsets.only(left:24.0, right: 24),
                              child: PrimaryColorOverride(
                                key:UniqueKey(),
                                child: TextFormField(
                                  style: textStyle,
                                  obscureText: _obscureText,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appStateModel.blocks.localeText.pleaseEnterPassword;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText ? Icons.visibility : Icons.visibility_off,color: Colors.white54
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          }
                                      ),
                                      errorStyle: errorStyle,
                                      labelStyle: labelStyle,
                                      border: InputBorder.none,
                                      labelText: appStateModel.blocks.localeText.password),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            RoundedLoadingButton(
                              color: Colors.white,
                              elevation: 0,
                              valueColor: Colors.black,
                              controller: _btnController,
                              onPressed: () => _submit(context),
                              animateOnTap: false,
                              width: 200,
                              child: Text(appStateModel.blocks.localeText.signIn, style: TextStyle(color: Color(0xFF00363a),fontSize: 20)),
                            ),
                            SizedBox(height: 30.0),
                            TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(left: 16.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => Material(child: ForgotPassword())));
                                },
                                child: Text(
                                    appStateModel.blocks.localeText.forgotPassword,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.6)
                                ))),

                              TextButton(
                                 style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(left: 16.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => Material(child: Register())));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        appStateModel.blocks.localeText
                                            .dontHaveAnAccount,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: 15,
                                            color: Colors.white.withOpacity(0.6)
                                        )),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                          appStateModel.blocks.localeText.signUp,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              color:
                                              Colors.white)),
                                    ),
                                  ],
                                )),

                            SizedBox(height: 30.0),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 50.0, // height of the button
                                      width: 50.0,
                                      child: Card(
                                        shape: StadiumBorder(),
                                        margin: EdgeInsets.all(0),
                                        color: Color(0xFFEA4335),
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Center(
                                            child: IconButton(
                                              splashRadius: 25.0,
                                              splashColor: Colors.transparent,
                                              icon: Icon(
                                                FontAwesomeIcons.google,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                _googleAuthentication(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  Platform.isIOS ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: StadiumBorder(),
                                      margin: EdgeInsets.all(0),
                                      color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFFFFFFF) : Color(0xFF000000),
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: IconButton(
                                          splashRadius: 25.0,
                                          icon: Icon(
                                            FontAwesomeIcons.apple,
                                            size: 20,
                                            color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                                          ),
                                          onPressed: () {
                                            appleLogIn(context);
                                            //_showDialog(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ) : Container(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: StadiumBorder(),
                                      margin: EdgeInsets.all(0),
                                      color: Color(0xFF34B7F1),
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: IconButton(
                                          splashRadius: 25.0,
                                          icon: Icon(
                                            FontAwesomeIcons.sms,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => Material(child: PhoneNumber())));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                ),
                ScopedModelDescendant<AppStateModel>(
                    builder: (context, child, model) {
                      if (model.loginLoading) {
                        return Center(
                          child: Dialog(
                            child: Container(
                              padding: EdgeInsets.all(24),
                              child: Wrap(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Text(appStateModel.blocks.localeText.pleaseWait),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
        ),
      ),
    );
  }

  _submit(BuildContext context) async {
    var login = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      login["username"] = usernameController.text;
      login["password"] = passwordController.text;
      _btnController.start();
      bool status = await appStateModel.login(login, context);
      _btnController.stop();
      if (status) {
        Navigator.of(context).pop();
      }
    }
  }

  //Google Login
  void _googleAuthentication(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    googleUser!.authentication
        .then((value) {
          if (value.idToken != null) {
            _loginGoogleUser(value.idToken!, googleUser, context);
          } else {
            // Handle the case where idToken is null
            print('Google Sign-In failed: idToken is null');
          }
        });
  }

  _loginGoogleUser(String idToken, GoogleSignInAccount googleUser,
      BuildContext context) async {
    var login = <String, dynamic>{};
    login["type"] = 'google';
    login["token"] = idToken;
    login["name"] = googleUser.displayName;
    login["email"] = googleUser.email;
    bool status = await appStateModel.googleLogin(login, context);
    if (status) {
      Navigator.of(context).pop();
    }
  }

 
  void _showCancelledMessage() {}

  void _showErrorOnUI(String errorMessage) {

  }

  Future _sendTokenToServer(token, BuildContext context) async {
    bool status = await appStateModel.facebookLogin(token);
    if (status) {
      Navigator.of(context).pop();
    }
  }

  //Apple Login
  appleLogIn(BuildContext context) async {

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId:
        'com.aboutyou.dart_packages.sign_in_with_apple.example',
        redirectUri: Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
    );

    var login = <String, dynamic>{};
    login["userIdentifier"] = credential.userIdentifier;
    login["authorizationCode"] = credential.authorizationCode;
    if(credential.email != null) {
      login["email"] = credential.email;
    } else {
      //await _showDialog(context);
      //TODO If email and name is empty Request Email and Name
    }
    if(credential.userIdentifier != null)
      login["email"] = credential.userIdentifier;
    if(credential.givenName != null)
      login["name"] = credential.givenName;
    else login["name"] = '';
    login["useBundleId"] = Platform.isIOS || Platform.isMacOS ? 'true' : 'false';
    bool status = await appStateModel.appleLogin(login);
    if (status) {
      Navigator.of(context).pop();
    }
    }

}
