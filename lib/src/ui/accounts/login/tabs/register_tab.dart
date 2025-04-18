//import './../../../../../l10n/gallery_localizations.dart';
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import './../../../../models/app_state_model.dart';
import './../../../../models/register_model.dart';
import './../tabs/register_text_form_field.dart';
import '../../../color_override.dart';
import '../../../widgets/buttons/button_text.dart';

class RegisterTab extends StatefulWidget {
  const RegisterTab({
    super.key,
    required this.context,
    required this.model,
    required this.tabController,
  });

  final BuildContext context;
  final AppStateModel model;
  final TabController tabController;

  @override
  _RegisterTabState createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final _formKey = GlobalKey<FormState>();

  final _register = RegisterModel(
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    password: '',
    username: '',
    companyName: '',
  );

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
                  height: 50,
                ),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    label: widget.model.blocks.localeText.firstName,
                    onSaved: (val) =>
                        setState(() => _register.firstName = val),
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterFirstName,
                    password: false,
                    inputType: TextInputType.text,
                    icon: Icons.person, controller: TextEditingController(),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    label: widget.model.blocks.localeText.lastName,
                    onSaved: (val) =>
                        setState(() => _register.lastName = val),
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterLastName,
                    password: false,
                    inputType: TextInputType.text,
                    icon: Icons.person,
                    controller: TextEditingController(),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    label: widget.model.blocks.localeText.phoneNumber,
                    onSaved: (val) =>
                        setState(() => _register.phoneNumber = val),
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterPhoneNumber,
                    password: false,
                    inputType: TextInputType.phone,
                    icon: Icons.phone,
                    controller: TextEditingController(),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    label: widget.model.blocks.localeText.email,
                    onSaved: (val) =>
                        setState(() => _register.email = val),
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterValidEmail,
                    password: false,
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    controller: TextEditingController(),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                PrimaryColorOverride(
                  key:UniqueKey(),
                  child: CustomTextFormField(
                    label: widget.model.blocks.localeText.password,
                    onSaved: (val) =>
                        setState(() => _register.password = val),
                    validationMsg: widget
                        .model.blocks.localeText.pleaseEnterPassword,
                    password: true,
                    inputType: TextInputType.text,
                    icon: Icons.vpn_key,
                    controller: TextEditingController(),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  child: ButtonText(isLoading: isLoading, text: widget.model.blocks.localeText.signUp),
                  onPressed: isLoading ? null : () => _registerUser(context),
                ),
                SizedBox(height: 12.0),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                    ),
                    onPressed: () {
                      widget.tabController.animateTo(0);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            widget.model.blocks.localeText
                                .alreadyHaveAnAccount,
                            style: Theme.of(context).textTheme.bodyMedium),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                              widget.model.blocks.localeText.signIn,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

  Future _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      bool status =
      await widget.model.register(_register.toJson(), context);
      setState(() {
        isLoading = false;
      });
      if (status) {
        Navigator.of(context).pop();
      }
    }
  }
}
