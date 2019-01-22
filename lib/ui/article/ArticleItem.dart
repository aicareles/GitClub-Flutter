import 'package:flutter/material.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/model/Article.dart';
import 'package:gitclub/ui/article/ArticleDetailPage.dart';
import 'package:gitclub/utils/StringUtils.dart';
import 'package:gitclub/utils/date_util.dart';
import 'package:gitclub/utils/timeline_util.dart';

///个人感觉条目比较复杂的话可以单独拿出来,而且可以复用.可以对比CollectListPage.dart中的item哪个更合理
class ArticleItem extends StatefulWidget {
  Article _itemData;

  //是否来自搜索列表
  bool _isSearch;

  //搜索列表的id
  String _id;

  ArticleItem(var itemData) {
    this._itemData = itemData;
    this._isSearch = false;
  }

  //命名构造函数,搜索列表的item和普通的item有些不一样
  ArticleItem.isFromSearch(var itemData, String id) {
    this._itemData = itemData;
    this._isSearch = true;
    this._id = id;
  }

  @override
  State<StatefulWidget> createState() {
    return new ArticleItemState();
  }
}

class ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 4.0,
      child: new InkWell(
        child: column(),
        onTap: () {
          _itemClick(widget._itemData);
        },
      ),
    );
  }

  void _itemClick(Article itemData) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
        title: itemData.title,
        url: itemData.link,
        article_id: itemData.article_id.toString(),
      );
    }));
  }

  Row row1() => new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
              child: new Row(
            children: <Widget>[
              new ClipOval(
                child: new FadeInImage.assetNetwork(
                    placeholder: Images.defalutHomeListAvatar,
                    fit: BoxFit.fitWidth,
                    image: widget._itemData.userModel.avatar,
                    width: Demins.ITEM_AVATAR_SIZE,
                    height: Demins.ITEM_AVATAR_SIZE),
              ),
              new Container(
                child: new Text(widget._itemData.userModel.nick_name,
                    style: new TextStyle(color: Theme.of(context).accentColor)),
                padding: EdgeInsets.all(5.0),
              )
            ],
          )),
          new Text(
            TimelineUtil.formatByDateTime(DateUtil.getDateTime(widget._itemData.date.toString())),
            style: TextStyle(color: AppColors.text),
          )
        ],
      );

  Row title() => new Row(
        children: <Widget>[
          new Expanded(
            child: new Text.rich(
              widget._isSearch
                  ? StringUtils.getTextSpan(widget._itemData.title, widget._id)
                  : new TextSpan(text: widget._itemData.title),
              softWrap: true,
              style: new TextStyle(
                  fontSize: FontSize.ITEM_TITLE_SIZE,
                  color: AppColors.textTitile),
              textAlign: TextAlign.left,
            ),
          )
        ],
      );

  Row imgUrl() => new Row(
//      mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Expanded(
              child: FadeInImage.assetNetwork(
                  placeholder: Images.TickImage,
                  width: widget._itemData.img_url.isNotEmpty ? 200.0 : 0.0,
                  height: widget._itemData.img_url.isNotEmpty ? 200.0 : 0.0,
                  image: widget._itemData.img_url,
                  fit: BoxFit.contain)),
        ],
      );

  Row viewStar() => new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Icon(Icons.remove_red_eye, color: Colors.black12),
              new Text(widget._itemData.views.toString(),
                  style: TextStyle(color: Colors.black12))
            ],
          ),
          new Row(
            children: <Widget>[
              new Icon(Icons.favorite_border, color: Colors.black12),
              new Text(widget._itemData.stars.toString(),
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

  Column column() => new Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(10.0),
            child: row1(),
          ),
          new Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: title(),
          ),
          new Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
            child: imgUrl(),
          ),
          new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
            child: viewStar(),
          )
        ],
      );
}
