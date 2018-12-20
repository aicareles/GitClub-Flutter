import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitclub/model/Article.dart';
import 'package:gitclub/ui/article/ArticleItem.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/ui/my/CollectionItem.dart';
import 'package:gitclub/widget/EndLine.dart';

class CollectionPage extends StatefulWidget {
  int tag = 0;//0:收藏  1：贡献

  CollectionPage(ValueKey<int> key) : super(key: key) {
    this.tag = key.value as int;
  }

  @override
  State<StatefulWidget> createState() {
    return new CollectionPageState();
  }
}

class CollectionPageState extends State<CollectionPage> {
  List listData = new List();

  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  ScrollController _contraller = new ScrollController();
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle =
      new TextStyle(color: Colors.blue, fontSize: 12.0);

  CollectionPageState() {
    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        getArticles();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  void dispose() {
    _contraller.dispose();
    super.dispose();
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getArticles();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new SafeArea(
        top: false,
        bottom: false,
        child: new Builder(
          builder: (BuildContext context) {
            return new CustomScrollView(
//              key: new PageStorageKey<_Page>(page),
              slivers: <Widget>[
                new SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                new SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  sliver: new SliverFixedExtentList(
                    itemExtent: 200.0,
                    delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
//                        final ArticleModel data = listData[index];
                        return new Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: buildItem(index),
                        );
                      },
                      childCount: listData.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }

  //我的收藏/贡献
  void getArticles() {
    String url = widget.tag == 0 ? Api.COLLECT_LIST : Api.CONTRIBUTE_LIST;
    Map<String, String> map = new Map();
    map["page"] = curPage.toString();
    map["size"] = "10";
    map["user_id"] = "3";
    HttpUtil.post(url, (data) {
      if (data != null) {
        List articles = data;
        var _listData = articles;
        listTotalSize += articles.length;
        setState(() {
          List list1 = new List();
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;

          list1.addAll(listData);
          list1.addAll(_listData);
          if (list1.length >= listTotalSize) {
            list1.add(Constants.END_LINE_TAG);
          }
          listData = list1;
        });
      }
    }, params: map);
  }

  Widget buildItem(int i) {
    var itemData = listData[i];

    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    return new CollectionItem(itemData);
  }
}
