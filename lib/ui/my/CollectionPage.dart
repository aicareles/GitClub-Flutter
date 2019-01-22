import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/constance/UserData.dart';
import 'package:gitclub/model/Article.dart';
import 'package:gitclub/ui/article/ArticleItem.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/ui/my/CollectionItem.dart';
import 'package:gitclub/widget/EndLine.dart';

class CollectionPage extends StatefulWidget {
  int tag = 0;//0:收藏  1：贡献
  ScrollController controller;

  CollectionPage(ValueKey<int> key, ScrollController _controller) : super(key: key) {
    this.tag = key.value as int;
    this.controller = _controller;
  }

  @override
  State<StatefulWidget> createState() {
    return new CollectionPageState();
  }
}

class CollectionPageState extends State<CollectionPage> {
  List<Article> listData = new List<Article>();

  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle =
      new TextStyle(color: Colors.blue, fontSize: 12.0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var maxScroll = widget.controller.position.maxScrollExtent;
      var pixels = widget.controller.position.pixels;
      if (maxScroll == pixels) {
        getArticles();
      }
    });
    getArticles();
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
            return listData.length != 0 ? new CustomScrollView(
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
                  )
                ),
              ],
            ) : Center(
              child: Text(widget.tag == 0 ? allTranslations.text('collect_empty') : allTranslations.text('submit_empty')),
            );
          },
        ),
      );
    }
  }

  //我的收藏/贡献
  void getArticles() async{
    String url = widget.tag == 0 ? Api.COLLECT_LIST : Api.CONTRIBUTE_LIST;
    Map<String, String> map = new Map();
    map[Parms.PAGE] = curPage.toString();
    map[Parms.SIZE] = Parms.SIZE_VALUE;
    await UserData.getUserId().then((userId){
      print("userid:"+userId.toString());
      map[Parms.USER_ID] = userId.toString();
    });
    HttpUtil.post(url, (data) {
      if (data != null) {
        List responseJson = data;
        List<Article> articles = responseJson.map((m) => Article.fromJson(m)).toList();
        listTotalSize += articles.length;
        setState(() {
          List<Article> list1 = new List<Article>();
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
    var itemData = listData[i];
    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new EndLine();
    }
    return new CollectionItem(itemData);
  }
}
