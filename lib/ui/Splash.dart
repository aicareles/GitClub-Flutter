import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/UserData.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    UserData.isLogin().then((isLogin) {
      if(isLogin) {
        Navigator.of(context).pushReplacementNamed('/home');
      }else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(Images.SplashImage,fit: BoxFit.fill);
  }
}
