import 'package:flutter/material.dart';
import 'package:gitclub/Components/Form.dart';
import 'package:gitclub/Components/SignInUpButton.dart';
import 'package:gitclub/Components/SignUpLink.dart';
import 'package:gitclub/Components/WhiteTick.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/constance/UserData.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/widget/Toast.dart';
import 'styles.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey;

  AnimationController _loginButtonController;
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  var animationStatus = 0;

  @override
  void initState() {
    super.initState();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 5000), vsync: this);
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

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure to exit?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/home"),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return (new WillPopScope(
//        onWillPop: _onWillPop,
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
                            FormType.LOGIN,
                            userNameController: _userNameController,
                            pwdController: _pwdController,
                          ),
                          new SignUp(
                            onPressed: () {
                              Navigator.pushNamed(context, "/register");
                            },
                          )
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
                                    login();
                                  },
                                  child: new SignInUp(FormType.LOGIN)),
                            )
                          : new StaggerAnimation(FormType.LOGIN,
                              buttonController: _loginButtonController.view),
                    ],
                  ),
                ],
              ))),
    )));
  }

  void login() {
    if(_userNameController.text.isEmpty || _pwdController.text.isEmpty){
      Toast.toast(context, allTranslations.text('name_pwd_empty'));
      cancelAnim();
      return;
    }
    print("_userNameController.text:"+_userNameController.text);
    String url = Api.LOGIN;
    Map<String, String> map = new Map();
    map["userName"] = _userNameController.text;
    map["password"] = _pwdController.text;
    HttpUtil.post(
        url,
        (data) {
          if (data != null) {
            cancelAnim();
            Toast.toast(context, allTranslations.text('login_success'));
            UserData.saveLoginInfo(data);
            Navigator.pushReplacementNamed(context, "/home");
          }
        },
        params: map,
        errorCallback: (msg) {
          cancelAnim();
          scaffoldKey.currentState
              .showSnackBar(new SnackBar(content: new Text(msg)));
        });
  }

  void cancelAnim(){
    setState(() {
      animationStatus = 0;
    });
    _loginButtonController.stop(canceled: false);
  }
}
