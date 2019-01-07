import 'package:flutter/material.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/ui/home/HomePage.dart';
import 'package:gitclub/ui/my/PersonPage.dart';
import 'package:gitclub/ui/NotFoundPage.dart';
import 'package:gitclub/ui/search/SearchPage.dart';
import 'package:gitclub/ui/Splash.dart';
import 'package:gitclub/ui/submit/SubmitPage.dart';
import 'package:gitclub/ui/test.dart';

//首页
class GitClubApp extends StatelessWidget {

  final navigatorKey = GlobalKey<NavigatorState>();

   static final materialApp = MaterialApp(
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: <String, WidgetBuilder>{
      "/home": (BuildContext context) => HomePage(),
      "/search": (BuildContext context) => SearchPage(null),
      "/person": (BuildContext context) => PersonPage(),
      "/submit": (BuildContext context) => SubmitPage(),
      "/test": (BuildContext context) => TestPage(),
    },
    onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
        builder: (context) => new NotFoundPage(
              appTitle: Constants.coming_soon,
              icon: Icons.error,
              title: Constants.coming_soon,
              message: "Under Development",
              iconColor: Colors.green,
            )),
    theme: new ThemeData(
        primaryColor: AppColors.colorPrimary,
        accentColor: AppColors.colorPrimary),
    home: SplashPage(),
//    home: TestPage(),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return materialApp;
  }
}
