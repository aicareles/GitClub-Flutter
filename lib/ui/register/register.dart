import 'package:flutter/material.dart';
import 'package:gitclub/Components/Form.dart';
import 'package:gitclub/Components/SignInUpButton.dart';
import 'package:gitclub/Components/WhiteTick.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/ui/login/loginAnimation.dart';
import 'package:gitclub/ui/login/styles.dart';
import 'package:gitclub/widget/Toast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey;
  AnimationController _loginButtonController;
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _pwdConfirmController = new TextEditingController();
  var animationStatus = 0;

  @override
  void initState() {
    super.initState();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        child: new Scaffold(
      key: scaffoldKey,
      body: new Container(
          decoration: new BoxDecoration(
            image: backgroundImage,
          ),
          child: new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                colors: <Color>[
                  const Color.fromRGBO(162, 146, 199, 0.8),
                  const Color.fromRGBO(51, 51, 63, 0.9),
                ],
                stops: [0.2, 1.0],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              )),
              child: new ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  new Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Tick(image: tick),
                          new FormContainer(
                            FormType.REGISTER,
                            userNameController: _userNameController,
                            pwdController: _pwdController,
                            pwdConfirmController: _pwdConfirmController,
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                            top: 160.0,
                          ))
                        ],
                      ),
                      animationStatus == 0
                          ? new Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: new InkWell(
                                  onTap: () {
                                    setState(() {
                                      animationStatus = 1;
                                    });
                                    _playAnimation();
                                    register();
                                  },
                                  child: new SignInUp(FormType.REGISTER)),
                            )
                          : new StaggerAnimation(FormType.REGISTER,
                              buttonController: _loginButtonController.view),
                    ],
                  ),
                ],
              ))),
    )));
  }

  void register() {
    if (_userNameController.text.isEmpty || _pwdController.text.isEmpty || _pwdConfirmController.text.isEmpty) {
      Toast.toast(context, allTranslations.text('form_empty'));
      cancelAnim();
      return;
    }
    if(_pwdController.text != _pwdConfirmController.text) {
      Toast.toast(context, allTranslations.text('pwd_no_same'));
      cancelAnim();
      return;
    }
    String url = Api.REGISTER;
    Map<String, String> map = new Map();
    map["nick_name"] = _userNameController.text;
    map["password"] = _pwdController.text;
    HttpUtil.post(
        url,
        (data) {
          if (data != null) {
            cancelAnim();
            Toast.toast(context, allTranslations.text('register_success'));
            Navigator.pushReplacementNamed(context, "/login");
          }
        },
        params: map,
        errorCallback: (msg) {
          cancelAnim();
          scaffoldKey.currentState
              .showSnackBar(new SnackBar(content: new Text(msg)));
        });
  }

  void cancelAnim() {
    setState(() {
      animationStatus = 0;
    });
    _loginButtonController.stop(canceled: false);
  }
}
