import 'package:flutter/material.dart';
import 'package:gitclub/ui/article/ArticleDetailPage.dart';
import 'package:gitclub/utils/DataUtils.dart';
import 'package:gitclub/utils/StringUtils.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';

///个人感觉条目比较复杂的话可以单独拿出来,而且可以复用.可以对比CollectListPage.dart中的item哪个更合理
class ArticleItem extends StatefulWidget {
  var itemData;

  //是否来自搜索列表
  bool isSearch;

  //搜索列表的id
  String id;

  ArticleItem(var itemData) {
    this.itemData = itemData;
    this.isSearch = false;
  }

  //命名构造函数,搜索列表的item和普通的item有些不一样
  ArticleItem.isFromSearch(var itemData, String id) {
    this.itemData = itemData;
    this.isSearch = true;
    this.id = id;
  }

  @override
  State<StatefulWidget> createState() {
    return new ArticleItemState();
  }
}

class ArticleItemState extends State<ArticleItem> {
  void _handleOnItemCollect(itemData) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        _login();
      } else {
//        _itemCollect(itemData);
      }
    });
  }

  _login() {
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return new LoginPage();
//    }));
  }

  void _itemClick(itemData) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
        title: itemData['title'],
        url: itemData['link'],
      );
    }));
  }

  //收藏/取消收藏
  void _itemCollect(var itemData) {
    String url;
    if (itemData['collect']) {
//      url = Api.UNCOLLECT_ORIGINID;
    } else {
      url = Api.COLLECT;
    }
    Map<String, String> map = new Map();
    map["article_id"] = itemData['article_id'];
    map["user_id"] = '3';
    map["type"] = '1';
    map["status"] = '1';
    HttpUtil.post(url, (data) {
      setState(() {
        itemData['collect'] = !itemData['collect'];
      });
    }, params: map);
  }

  @override
  Widget build(BuildContext context) {
//    bool isCollect = widget.itemData["collect"];

    Row row1 = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Row(
              children: <Widget>[
                new ClipOval(
                  child: new FadeInImage.assetNetwork(
                      placeholder: "images/ic_launcher_round.png",
                      fit: BoxFit.fitWidth,
                      image: widget.itemData['user']['avatar'],
                      width: 30.0,
                      height: 30.0
                  ),
                ),
                new Container(
                  child: new Text(
                      widget.itemData['user']['nick_name'],
                      style: new TextStyle(color: Theme
                          .of(context)
                          .accentColor)
                  ),
                  padding: EdgeInsets.all(5.0),
                )

              ],
            )),
        new Text(widget.itemData['date'])
      ],
    );

    Row title = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text.rich(
            widget.isSearch
                ? StringUtils.getTextSpan(widget.itemData['title'], widget.id)
                : new TextSpan(text: widget.itemData['title']),
            softWrap: true,
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Row imgUrl = new Row(
//      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          child: new Image.network(
            widget.itemData['img_url'],
          ),
        ),
      ],
    );

    Row viewStar = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Icon(Icons.remove_red_eye, color: Colors.black12),
            new Text(widget.itemData['views'].toString(),
                style: TextStyle(color: Colors.black12))
          ],
        ),
        new Row(
          children: <Widget>[
            new Icon(Icons.favorite_border, color: Colors.black12),
            new Text(widget.itemData['stars'].toString(),
                style: TextStyle(color: Colors.black12))
          ],
        ),
//        new GestureDetector(
//          child: new Row(
//            children: <Widget>[
//              new Icon(Icons.favorite_border, color: Colors.black12),
//              new Text(widget.itemData['stars'].toString(),
//                  style: TextStyle(color: Colors.black12))
//            ],
//          ),
//          onTap: () {
//            _handleOnItemCollect(widget.itemData);
//          },
//        )
      ],
    );

    Column column = new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: row1,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: imgUrl,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
          child: viewStar,
        )
      ],
    );

    return new Card(
      elevation: 4.0,
      child: new InkWell(
        child: column,
        onTap: () {
          _itemClick(widget.itemData);
        },
      ),
    );
  }
}
