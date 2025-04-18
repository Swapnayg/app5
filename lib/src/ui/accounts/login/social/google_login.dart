// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './../../../../models/app_state_model.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class GoogleLoginWidget extends StatelessWidget {
  final appStateModel = AppStateModel();

  GoogleLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: StadiumBorder(),
      margin: EdgeInsets.all(0),
      color: Color(0xFFEA4335),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Center(
          child: IconButton(
            //splashRadius: 25.0,
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
    );
  }

  void _googleAuthentication(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    googleUser!.authentication
        .then((value) {
          if (value.idToken != null) {
            _loginGoogleUser(value.idToken!, googleUser, context);
          } else {
            // Handle the case where idToken is null
            debugPrint('Google Sign-In failed: idToken is null');
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
}
