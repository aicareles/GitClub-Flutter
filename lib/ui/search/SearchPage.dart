import 'package:flutter/material.dart';
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
  // 光标跳转的输入框对象
  FocusNode focusNode = FocusNode();

  SearchListPage _searchListPage;
  String searchStr ;
  SearchPageState(this.searchStr);

  @override
  void initState() {
    super.initState();
    initKeyDatas();
    _searchController = new TextEditingController(text: searchStr);
    changeContent();
  }

  void changeContent(){
    setState(() {
        _searchListPage = new SearchListPage(new ValueKey(_searchController.text));
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
        hintText: '搜索关键词',
        hintStyle: new TextStyle(color: Colors.white),
        labelStyle: new TextStyle(color: Colors.white)
      ),
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
      body: (_searchController.text==null||_searchController.text.isEmpty)?new Center(
        child: new ListView(
          children: <Widget>[
            new Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: hotkeyWidgets,
            )
          ],
        )
      ):_searchListPage,

    );
  }

  void initKeyDatas() {
    hotkeyWidgets.clear();
    hotkeyDatas.clear();
    hotkeyDatas.add("自定义View");
    hotkeyDatas.add("Tab");
    hotkeyDatas.add("WebView");
    hotkeyDatas.add("蓝牙");
    hotkeyDatas.add("数据库");
    hotkeyDatas.add("完整项目");
    hotkeyDatas.add("人脸识别");

    for(var value in hotkeyDatas){
      hotkeyWidgets.add(new ActionChip(
          label: new Text(
            value,
            style: new TextStyle(color: Colors.white),
          ), onPressed: (){
            Navigator
                .of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context){
                return new SearchPage(value);
            }));
      }));
    }
  }
}


