import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/model/Article.dart';
import 'package:gitclub/ui/article/ArticleItem.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/widget/EndLine.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage> {
  List<ArticleModel> listData = new List<ArticleModel>();

  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  ScrollController _contraller = new ScrollController();
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle =
      new TextStyle(color: AppColors.colorPrimary, fontSize: 12.0);

  HomeListPageState() {
    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        getArticlelist();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getArticlelist();
  }

  @override
  void dispose() {
    _contraller.dispose();
    super.dispose();
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getArticlelist();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length + 1,
        itemBuilder: (context, i) => buildItem(i),
        controller: _contraller,
      );

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
        List<ArticleModel> articles = responseJson.map((m) => ArticleModel.fromJson(m)).toList();
        listTotalSize += data.length;
        setState(() {
          List<ArticleModel> list1 = new List<ArticleModel>();
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;

          list1.addAll(listData);
          list1.addAll(articles);
//          if (list1.length >= listTotalSize) {
//            list1.add(Constants.END_LINE_TAG);
//          }
          listData = list1;
        });
      }
    }, params: map);
  }

  Widget buildItem(int i) {
    if (i == 0) {
      return new Container(
        height: 0.0,
      );
    }
    i -= 1;

    var itemData = listData[i];

    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    return new ArticleItem(itemData);
  }
}
