import 'package:flutter/material.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/ui/search/SearchListPage.dart';

class SearchPage extends StatefulWidget {
  String searchStr;

  SearchPage(this.searchStr);

  @override
  State<StatefulWidget> createState() {
    return new SearchPageState(searchStr);
  }
}

class SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = new TextEditingController();
  List<Widget> hotkeyWidgets = new List();
  List<String> hotkeyDatas = new List();
  List<Widget> newWidgets = new List();
  List<String> newDatas = new List();

  // 光标跳转的输入框对象
  FocusNode focusNode = FocusNode();

  SearchListPage _searchListPage;
  String searchStr;

  SearchPageState(this.searchStr);

  @override
  void initState() {
    super.initState();
    initKeyDatas();
    initNewDatas();
    _searchController = new TextEditingController(text: searchStr);
    changeContent();
  }

  void changeContent() {
    setState(() {
      _searchListPage =
          new SearchListPage(new ValueKey(_searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      style: new TextStyle(color: Colors.white),
      autofocus: false,
      focusNode: focusNode,
      decoration: new InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.white,
          hintText: allTranslations.text('search_key'),
          hintStyle: new TextStyle(color: Colors.white),
          labelStyle: new TextStyle(color: Colors.white)),
      controller: _searchController,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                changeContent();
                focusNode.unfocus();
              }),
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                focusNode.unfocus();
                setState(() {
                  _searchController.clear();
                });
              }),
        ],
      ),
      body: (_searchController.text == null || _searchController.text.isEmpty)
          ? new Center(
              child: new ListView(
              children: <Widget>[
                new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Text(allTranslations.text('hot_key'),
                        style: new TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0))),
                new Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: hotkeyWidgets,
                  ),
                ),
                new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Text(allTranslations.text('new_key'),
                        style: new TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0))),
                new Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: newWidgets,
                  ),
                )
              ],
            ))
          : _searchListPage,
    );
  }

  void initKeyDatas() {
    hotkeyWidgets.clear();
    hotkeyDatas.clear();
    hotkeyDatas.add("Flutter");
    hotkeyDatas.add("自定义View");
    hotkeyDatas.add("Wifi");
    hotkeyDatas.add("完整项目");
    hotkeyDatas.add("人脸识别");
    hotkeyDatas.add("数据库");
    hotkeyDatas.add("蓝牙");
    hotkeyDatas.add("动画");
    hotkeyDatas.add("自定义图表");

    for (var value in hotkeyDatas) {
      hotkeyWidgets.add(new ActionChip(
          label: new Text(
            value,
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context) {
              return new SearchPage(value);
            }));
          }));
    }
  }

  void initNewDatas() {
    newWidgets.clear();
    newDatas.clear();
    newDatas.add(allTranslations.text('video_key'));
    newDatas.add(allTranslations.text('beauty_key'));

    for (var value in newDatas) {
      newWidgets.add(new ActionChip(
          label: new Text(
            value,
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (value == allTranslations.text('beauty_key')) {
              Navigator.pushNamed(context, "/meizi");
            } else {
              Navigator.pushNamed(context, "/video");
            }
          }));
    }
  }
}
