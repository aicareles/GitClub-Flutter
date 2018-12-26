import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitclub/model/Article.dart';
import 'package:gitclub/ui/article/ArticleItem.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/widget/EndLine.dart';

class SearchListPage extends StatefulWidget {
  String queryKey;

  //这里为什么用含有key的这个构造,大家可以试一下不带key 直接SearchListPage(this.id) ,看看会有什么bug;

  SearchListPage(ValueKey<String> key) : super(key: key) {
    this.queryKey = key.value.toString();
  }

  SearchListPageState searchListPageState;

  @override
  State<StatefulWidget> createState() {
    return new SearchListPageState();
  }
}

class SearchListPageState extends State<SearchListPage> {
  int curPage = 0;

  Map<String, String> map = new Map();
  List<ArticleModel> listData = new List<ArticleModel>();
  int listTotalSize = 0;
  ScrollController _contraller = new ScrollController();

  @override
  void initState() {
    super.initState();

    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _articleQuery();
      }
    });

    _articleQuery();
  }

  @override
  void dispose() {
    _contraller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => buildItem(i),
        controller: _contraller,
      );

      return new RefreshIndicator(child: listView, onRefresh: pullToRefresh);
    }
  }

  void _articleQuery() {
    String url = Api.ARTICLE_QUERY;
    map[Parms.PAGE] = curPage.toString();
    map[Parms.SIZE] = Parms.SIZE_VALUE;
    map[Parms.QUERY] = widget.queryKey;

    HttpUtil.post(url, (data) {
      if (data != null) {
//        List articles = data;
        List responseJson = data;
        List<ArticleModel> articles = responseJson.map((m) => ArticleModel.fromJson(m)).toList();
        listTotalSize = articles.length;
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

  Future<Null> pullToRefresh() async {
    curPage = 0;
    _articleQuery();
    return null;
  }

  Widget buildItem(int i) {
    var itemData = listData[i];

    if (i == listData.length - 1 &&
        itemData.toString() == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    return new ArticleItem.isFromSearch(itemData, widget.queryKey);
  }
}
