// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously, unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import './../../../../models/app_state_model.dart';

class AppleLogin extends StatelessWidget {

  final appStateModel = AppStateModel();
  TextEditingController emailController = TextEditingController();

  AppleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: StadiumBorder(),
      margin: EdgeInsets.all(0),
      color: Theme.of(context).brightness == Brightness.dark ? Color(0xFFFFFFFF) : Color(0xFF000000),
      child: SizedBox(
        height: 50,
        width: 50,
        child: IconButton(
          //splashRadius: 25.0,
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
    );
  }

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

  _showDialog(BuildContext context) async {
    await showDialog<String>(
      builder: (context) => _SystemPadding(child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: emailController,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Enter you email', hintText: ''),
              ),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.pop(context, );
              })
        ],
      ),), context: context,
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  const _SystemPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
