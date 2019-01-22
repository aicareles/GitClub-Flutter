import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/app/Translations.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/model/Article.dart';
import 'package:gitclub/ui/article/ArticleItem.dart';
import 'package:gitclub/ui/MyApp.dart';
import 'package:gitclub/ui/search/SearchPage.dart';
import 'package:gitclub/widget/EndLine.dart';
import 'package:gitclub/widget/FloatButton.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Article> listData = new List<Article>();
  bool _isVisible = true;

  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  ScrollController _controller = new ScrollController();
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle =
      new TextStyle(color: AppColors.colorPrimary, fontSize: 12.0);

  @override
  void initState() {
    super.initState();
    getArticlelist();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        getArticlelist();
      }
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getArticlelist();
    return null;
  }

  Widget homeList() {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = NotificationListener(
          onNotification: (scrollNotification) {
//            if (scrollNotification is ScrollStartNotification) {
//              //开始滑动
//            } else if (scrollNotification is ScrollUpdateNotification) {
//              //正在滑动
//              setState(() {
//                _isVisible = false;
//              });
//            } else if (scrollNotification is ScrollEndNotification) {
//              //滑动结束
//              setState(() {
//                _isVisible = true;
//              });
//            }
          },
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: listData.length + 1,
            itemBuilder: (context, i) => buildItem(i),
            controller: _controller,
          ));

      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void getArticlelist() {
    String url = Api.ARTICLE_LIST;
    Map<String, String> map = new Map();
    map[Parms.PAGE] = curPage.toString();
    map[Parms.SIZE] = Parms.SIZE_VALUE;
    HttpUtil.post(url, (data) {
      if (data != null) {
        List responseJson = data;
        List<Article> articles =
            responseJson.map((m) => Article.fromJson(m)).toList();
        listTotalSize += data.length;
        setState(() {
          List<Article> list1 = new List<Article>();
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;
          list1.addAll(listData);
          list1.addAll(articles);
          listData = list1;
        });
      }
    }, params: map);
  }

  Widget buildItem(int i) {
    if (i == 0) {
      return Container();
    }
    i -= 1;
    var itemData = listData[i];
    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return EndLine();
    }
    return ArticleItem(itemData);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
//          Translations.of(context).text('main_title'),
          allTranslations.text('app_name'),
          style: new TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () async {
                GitClubAppState.materialApp.navigatorKey.currentState.push(
                    new MaterialPageRoute(
                        builder: (context) => new SearchPage(null)));
              })
        ],
      ),
      body: homeList(),
      floatingActionButton: Opacity(
        opacity: _isVisible ? 1.0 : 0.0,
        child: new FancyFab(
          onPersonPressed: () {
            Navigator.pushNamed(context, "/person");
          },
          onSubmitPressed: () {
            Navigator.pushNamed(context, "/submit");
          },
        ),
      ),
    );
  }
}
