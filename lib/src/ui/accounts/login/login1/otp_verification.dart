// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import './../../../../models/app_state_model.dart';
import './../../../../ui/widgets/buttons/button.dart';

import '../../../color_override.dart';

class OTPVerification extends StatefulWidget {

  OTPVerification({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  String verificationId;
  final String phoneNumber;

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {

  final appStateModel = AppStateModel();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) => ListView(
          shrinkWrap: true,
          children: [
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
                      height: 16,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 6) {
                              showSnackBar(context, 'Invalid Code');
                              return null;
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            inactiveColor: Colors.grey.withOpacity(.2),
                            inactiveFillColor: Colors.white,
                            disabledColor: Colors.grey,
                            selectedColor: Colors.blue,
                            activeColor: Colors.black,
                            selectedFillColor: Colors.white,
                            shape: PinCodeFieldShape.box,
                            borderWidth: 2,
                            borderRadius: BorderRadius.circular(3),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          // backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            //
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    AccentButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          verifyOTP(context);
                        }
                      },
                      text: appStateModel.blocks.localeText.signIn,
                      showProgress: isLoading,
                    ),
                    TextButton(
                        onPressed: () {
                          sendOTP(context);
                        },
                        child: Text(
                            appStateModel.blocks.localeText.resendOTP,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.grey
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  verifyOTP(BuildContext context) async {

    setState(() {
      isLoading = true;
    });

    //Server end verification
    var data = <String, dynamic>{};
    data["smsOTP"] = otpController.text;
    data["verificationId"] = widget.verificationId;
    data["phoneNumber"] = widget.phoneNumber;
    bool status = await appStateModel.phoneLogin(data, context);
    if (status) {
      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
    }

    //Local verification. Do not use this, Use server end verification instead
    /*PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otpController.text);
    try {
      await _auth.signInWithCredential(phoneAuthCredential);
      //Wordpress Login user with
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'The SMS verification code used is invalid.');
    }*/

    setState(() {
      isLoading = false;
    });
  }

  showSnackBar(BuildContext context, String message) {
    //Fluttertoast.showToast(msg: message, gravity: ToastGravity.TOP);

    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> sendOTP(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: widget.phoneNumber,
          codeAutoRetrievalTimeout: (String verId) {
            widget.verificationId = verId;
          },
          codeSent: (String verId, [int? forceCodeResend]) {
            setState(() {
              isLoading = false;
            });
            widget.verificationId = verId;
          },
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            onVerificationCompleted(phoneAuthCredential);
            await _auth.signInWithCredential(phoneAuthCredential);
            setState(() {
              isLoading = false;
            });
          },
          verificationFailed: (exception) {
            handlePhoneNumberError(exception, context);
            setState(() {
              isLoading = false;
            });
          });
    } catch (e) {
      handleOtpError(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  handleOtpError(error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        showSnackBar(context, appStateModel.blocks.localeText.inValidCode);
        break;
      default:
        showSnackBar(context, appStateModel.blocks.localeText.inValidCode);
        break;
    }
  }

  handlePhoneNumberError(FirebaseAuthException error, BuildContext context) {
    switch (error.code) {
      case 'TOO_LONG':
        FocusScope.of(context).requestFocus(FocusNode());
        showSnackBar(context, appStateModel.blocks.localeText.inValidNumber);
        break;
      case 'TOO_SHORT':
        FocusScope.of(context).requestFocus(FocusNode());
        showSnackBar(context, appStateModel.blocks.localeText.inValidNumber);
        Navigator.of(context).pop();
        break;
      case 'SESSION_EXPIRED':
        break;
      case 'INVALID_SESSION_INFO':
        break;
      default:
        showSnackBar(context, appStateModel.blocks.localeText.inValidNumber);
        break;
    }
  }

  onVerificationCompleted(AuthCredential phoneAuthCredential) {
    //TODO Wordpress Login User
  }
}
