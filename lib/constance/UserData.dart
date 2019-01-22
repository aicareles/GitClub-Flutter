import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserData {
  static final String IS_LOGIN = "isLogin";
  static final String USERNAME = "userName";
  static final String USERID = "userId";

  // 保存用户登录信息，data中包含了userName
  static Future saveLoginInfo(var user) async {
    print('isLogin');
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(USERNAME, user['nick_name']);
    await sp.setInt(USERID, user['user_id']);
    await sp.setBool(IS_LOGIN, true);
  }

  static Future clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print('clean');
    return sp.clear();
  }


  static Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(USERNAME);
  }

  static Future<int> getUserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(USERID);
  }


  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(IS_LOGIN);
    return true == b;
  }
}
