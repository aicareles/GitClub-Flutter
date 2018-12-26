import 'package:flutter/material.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/ui/home/HomePage.dart';
import 'package:gitclub/ui/my/Person.dart';
import 'package:gitclub/ui/notfound_page.dart';
import 'package:gitclub/ui/search/SearchPage.dart';
import 'package:gitclub/ui/splash.dart';
import 'package:gitclub/ui/submit/SubmitPage.dart';

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
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return materialApp;
  }
}
