import 'package:flutter/material.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/model/Article.dart';
import 'package:gitclub/ui/article/ArticleDetailPage.dart';

///个人感觉条目比较复杂的话可以单独拿出来,而且可以复用.可以对比CollectListPage.dart中的item哪个更合理
class CollectionItem extends StatefulWidget {
  Article itemData;

  CollectionItem(var itemData) {
    this.itemData = itemData;
  }

  @override
  State<StatefulWidget> createState() {
    return new CollectionItemState();
  }
}

class CollectionItemState extends State<CollectionItem> {

  void _itemClick(Article itemData) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
        title: itemData.title,
        url: itemData.link,
        article_id: itemData.article_id.toString(),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    Row row1 = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Row(
              children: <Widget>[
                new ClipOval(
                  child: new FadeInImage.assetNetwork(
                      placeholder: Images.defalutHomeListAvatar,
                      fit: BoxFit.fitWidth,
                      image: widget.itemData.userModel.avatar,
                      width: Demins.ITEM_AVATAR_SIZE,
                      height: Demins.ITEM_AVATAR_SIZE
                  ),
                ),
                new Container(
                  child: new Text(
                      widget.itemData.userModel.nick_name,
                      style: new TextStyle(color: Theme
                          .of(context)
                          .accentColor)
                  ),
                  padding: EdgeInsets.all(5.0),
                )

              ],
            )),
        new Text(widget.itemData.date)
      ],
    );

    Row title = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text.rich(
            new TextSpan(text: widget.itemData.title),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(fontSize: FontSize.ITEM_TITLE_SIZE, color: AppColors.textBlack),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Text des = new Text(
        widget.itemData.des,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: new TextStyle(color: Theme
            .of(context)
            .accentColor)
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
          child: des,
        ),
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
