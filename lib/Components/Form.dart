import 'package:flutter/material.dart';
import './InputFields.dart';

class FormContainer extends StatelessWidget {
  FormType _formType;
  TextEditingController userNameController;
  TextEditingController pwdController;
  TextEditingController pwdConfirmController;

  FormContainer(this._formType,
      {this.userNameController, this.pwdController, this.pwdConfirmController});

  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new InputFieldArea(
                hint: "Username",
                controller: userNameController,
                validatorTip: "用户名不能为空",
                obscure: false,
                icon: Icons.person_outline,
              ),
              new InputFieldArea(
                hint: "Password",
                controller: pwdController,
                validatorTip: "密码不能为空",
                obscure: true,
                icon: Icons.lock_outline,
              ),
              _formType == FormType.LOGIN
                  ? Container()
                  : new InputFieldArea(
                      hint: "Password Confirm",
                      controller: pwdConfirmController,
                      validatorTip: "确认密码不能为空",
                      obscure: true,
                      icon: Icons.lock_outline,
                    ),
            ],
          )),
        ],
      ),
    ));
  }
}

enum FormType { LOGIN, REGISTER }
