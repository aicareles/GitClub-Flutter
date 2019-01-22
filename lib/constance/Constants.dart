import 'package:event_bus/event_bus.dart';


class Constants {

  static EventBus eventBus = new EventBus();

  static final String END_LINE_TAG = "COMPLETE";

  static const String coming_soon = "Coming Soon";
}

class App {
  static const String appName = "GitClub";
}

class Routes {
  static const String homeRoute = "/home";
}

class Fonts {
  static const String quickFont = "Quicksand";
}

class Images {
  static const String imageDir = "assets/images";
  static const String defalutHomeListAvatar = "$imageDir/ic_launcher_round.png";
  static const String defalutBeauty = "$imageDir/defalutBeauty.jpg";
  static const String SplashImage = "$imageDir/splash.jpg";
  static const String LoginBackground = "$imageDir/login.jpg";
  static const String TickImage = "$imageDir/tick.png";
}

class Parms {
  static final String PAGE = "page";
  static final String SIZE = "size";
  static final String QUERY = "query";
  static final String USER_ID = "user_id";
  static final String ARTICLE_ID = "article_id";
  static final String SIZE_VALUE = "10";
}

class Demins {
  static final double ITEM_AVATAR_SIZE = 30.0;

}

class FontSize {
  static final double ITEM_TITLE_SIZE = 16.0;
}
