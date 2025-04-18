import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './../../../models/app_state_model.dart';
import 'login1/login.dart';
import 'login2/login.dart';
import 'login3/login3.dart';
import 'login4/login.dart';
import 'login5/login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          print(model.blocks.pageLayout.login);
          if (model.blocks.pageLayout.login == 'layout1') {
            return Login1();
          } else if (model.blocks.pageLayout.login == 'layout2') {
            return Login2();
          } else if (model.blocks.pageLayout.login == 'layout3') {
            return Login3(model: model,);
          } else if (model.blocks.pageLayout.login == 'layout4') {
            return Login4();
          } else if (model.blocks.pageLayout.login == 'layout5') {
            return Login5();
          }  else {
            return Login5();
          }
        });
  }
}


