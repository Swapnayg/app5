// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, deprecated_member_use, use_build_context_synchronously, unused_field, sort_child_properties_last

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../models/app_state_model.dart';
import '../../../widgets/buttons/button_text.dart';
import '../../../widgets/buttons/base_text_field.dart';
import '../custom_alert_dialogue.dart';

const kFullTabHeight = 60.0;

class PhoneVerification extends StatefulWidget {
  final bool fullscreen;
  final appStateModel = AppStateModel();

  PhoneVerification({super.key, 
    required this.fullscreen,
  });

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification>
    with TickerProviderStateMixin {
  static const tabBorderRadius = BorderRadius.all(Radius.circular(4.0));
  var _currentIndex = 0;
  var _showTabs = true;
  late TabController _tabController;
  final double _tabHeight = kFullTabHeight;
  late AnimationController _animationController;
  final appStateModel = AppStateModel();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var loadingSendOtp = false;
  final _formKey = GlobalKey<FormState>();
  var _loadingOtp = false;
  String prefixCode = '+91';

  late String verificationId;

  late String smsOTP;

  String errorMessage = '';

  var _loadingNumber = false;

  late String _phoneNumber;


  @override
  void initState() {
    prefixCode = appStateModel.blocks.settings.countryDialCode;
    //_initMethods();
    _currentIndex = _getCurrentTab();
    _showTabs = true;
    _tabController =
        TabController(vsync: this, length: 2, initialIndex: _currentIndex);
    _tabController.addListener(_indexChange);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      expanded: true,
      fullscreen: widget.fullscreen,
      titlePadding: EdgeInsets.all(0.0),
      onCancelPress: _onCancelPress,
      title: _buildTitle(),
      content: Container(
        child: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  _currentIndex == 0
                      ? _mobileNumberEntryCard()
                      : buildOtpEntryCard(context),
                  //_methodWidgets[_currentIndex].child,
                  SizedBox(height: 20),
                ],
              )),
        ),
      ),
    );
  }

  Container buildOtpEntryCard(BuildContext context) {
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.disabled, key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            BaseTextField(
              labelText: widget.appStateModel.blocks.localeText.enterOtp, // 'ENTER OTP(6 digits)',
              hintText: widget.appStateModel.blocks.localeText.enterOtpHint, // Provide a hint text
              controller: TextEditingController(), // Provide a controller
              initialValue: '', // Provide an initial value
              suffix: Icon(Icons.lock), // Provide a suffix widget
              validator: (String? value) {
                if (value!.trim().isEmpty) return widget.appStateModel.blocks.localeText.inValidCode;
                return value.length == 6 ? null : widget.appStateModel.blocks.localeText.inValidCode;
              },
              onSaved: (String? value) {
                smsOTP = value!;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: ButtonText(isLoading: _loadingOtp, text: widget.appStateModel.blocks.localeText.verifyOtp),
                onPressed: _loadingOtp ? null : () => _verifyOTP(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      height: _tabHeight,
      alignment: Alignment.center,
      child: Text(
        widget.appStateModel.blocks.localeText.signIn,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
      ),
    );
  }

  void _indexChange() {
    setState(() {
      _currentIndex = _tabController.index;
      // Update the checkout here just in case the user terminates the transaction
      // forcefully by tapping the close icon
    });
  }

  int _getCurrentTab() {
    int checkedTab;
    checkedTab = 0;
    return checkedTab;
  }

  Future<void> _verifyOTP(BuildContext context) async {
    _formKey.currentState!.save();

    setState(() {
      _loadingOtp = true;
    });
    //TODO VERIFY OTP

    var login = <String, dynamic>{};
    login["smsOTP"] = smsOTP;
    login["verificationId"] = verificationId;
    login["phoneNumber"] = _phoneNumber;
    bool status = await widget.appStateModel.phoneLogin(login, context);
    setState(() {
      _loadingOtp = false;
    });
    if (status) {
      Navigator.pop(context, status);
    }

    /*try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;

      user.getIdToken().then((value) => print(value));

      var login = new Map<String, dynamic>();
      login["name"] = '';
      login["phone"] = user.phoneNumber;
      login["smsOTP"] = smsOTP;
      login["verificationId"] = verificationId;
      bool status = await widget.appStateModel.phoneLogin(login);
      setState(() {
        _loadingOtp = false;
      });
      if (status) {
        Navigator.pop(context, status);
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _loadingOtp = false;
      });
      handleOtpError(e);
    }*/
  }

  handleOtpError(error) {
    print(error.code);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        Fluttertoast.showToast(msg: widget.appStateModel.blocks.localeText.inValidCode);
        Navigator.of(context).pop();
        break;
      default:
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: error.message);
        break;
    }
  }

  _mobileNumberEntryCard() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: <Widget>[
              CountryCodePicker(
                onChanged: _onCountryChange,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: appStateModel.blocks.settings.defaultCountry,
                favorite: [prefixCode, appStateModel.blocks.settings.defaultCountry],
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
              ),
              SizedBox(
                width: 0.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Form(
                    key: _formKey,
                    child: BaseTextField(
                      labelText: widget.appStateModel.blocks.localeText.phoneNumber,
                      hintText: widget.appStateModel.blocks.localeText.enterPhoneNumberHint, // Provide a hint text
                      controller: TextEditingController(), // Provide a controller
                      initialValue: '', // Provide an initial value
                      suffix: Icon(Icons.phone), // Provide a suffix widget
                      validator: (String? value) {
                        if (value!.trim().isEmpty) return widget.appStateModel.blocks.localeText.pleaseEnterPhoneNumber;
                        return value.length == 0 ? null : widget.appStateModel.blocks.localeText.pleaseEnterPhoneNumber;
                      },
                      onSaved: (String? value) {
                        _phoneNumber = value!;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child:
                  ButtonText(isLoading: _loadingNumber, text: widget.appStateModel.blocks.localeText.verifyNumber),
              onPressed: _loadingNumber ? null : _validateInputs,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _validateInputs() async {
    _formKey.currentState!.save();
    setState(() {
      _loadingNumber = true;
    });
    smsOTPSent(String verId, [int? forceCodeResend]) {
      verificationId = verId;
      setState(() {
        _loadingNumber = false;
        _tabController.index = 1;
      });
    }
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: prefixCode + _phoneNumber, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            _auth.signInWithCredential(phoneAuthCredential);
            setState(() {
              _loadingNumber = false;
              _tabController.index = 1;
            });
          },
          verificationFailed: (exception) {});
    } catch (e) {
      setState(() {
        _loadingNumber = false;
      });
      handlePhoneNumberError(e as PlatformException) ;
    }
  }

  handlePhoneNumberError(PlatformException error) {
    switch (error.code) {
      case 'TOO_LONG':
        FocusScope.of(context).requestFocus(FocusNode());
        Fluttertoast.showToast(msg: widget.appStateModel.blocks.localeText.inValidNumber);
        Navigator.of(context).pop();
        break;
      case 'TOO_SHORT':
        FocusScope.of(context).requestFocus(FocusNode());
        Fluttertoast.showToast(msg: widget.appStateModel.blocks.localeText.inValidNumber);
        Navigator.of(context).pop();
        break;
      default:
        //Fluttertoast.showToast(msg: error.message);
        Navigator.of(context).pop();
        break;
    }
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      prefixCode = countryCode.toString();
    });
  }

  void _onCancelPress() {
    Navigator.pop(context);
  }
}


typedef OnResponse<CheckoutResponse> = void Function(CheckoutResponse response);
