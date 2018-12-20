import 'package:flutter/material.dart';
import 'package:gitclub/ui/article/ArticleDetailPage.dart';

///个人感觉条目比较复杂的话可以单独拿出来,而且可以复用.可以对比CollectListPage.dart中的item哪个更合理
class CollectionItem extends StatefulWidget {
  var itemData;

  CollectionItem(var itemData) {
    this.itemData = itemData;
  }

  @override
  State<StatefulWidget> createState() {
    return new CollectionItemState();
  }
}

class CollectionItemState extends State<CollectionItem> {

  void _itemClick(itemData) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
        title: itemData['title'],
        url: itemData['link'],
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
            new TextSpan(text: widget.itemData['title']),
            softWrap: true,
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Text des = new Text(
        widget.itemData['des'],
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
