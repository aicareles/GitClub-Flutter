import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/UserData.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/ui/meizi/Category.dart';
import 'package:gitclub/ui/my/CollectionPage.dart';
import 'package:http/http.dart' as http;

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PersonPageState();
  }
}

class PersonPageState extends State<PersonPage> {
  static final DefalutUrl =
      "http://ww1.sinaimg.cn/large/7a8aed7bjw1f05pbp0p0yj20go0mu77b.jpg";
  bool _isVisible = true;
  ScrollController _controller = ScrollController();
  var meiziUrl = DefalutUrl;
  var userName = "";

  @override
  void initState() {
    super.initState();
    UserData.getUserName().then((username){
      setState(() {
        this.userName = username;
      });
    });
    getMeizi();
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
          body: new NestedScrollView(
            controller: _controller,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: new SliverAppBar(
                    title: Text(userName),
                    actions: <Widget>[
                      new IconButton(
                          icon: new Icon(Icons.settings),
                          onPressed: () async {
                            Navigator.pushNamed(context, "/set");
                          })
                    ],
                    pinned: false,
                    floating: false,
                    snap: false,
                    expandedHeight: 300.0,
                    // 这个高度必须比flexibleSpace高度大
                    forceElevated: innerBoxIsScrolled,
                    bottom: PreferredSize(
                        child: new Container(
                          child: new TabBar(
                            tabs: <Widget>[
                              Tab(text: allTranslations.text('collection')),
                              Tab(text: allTranslations.text('contribution')),
                            ],
                          ),
                          color: Colors.blue,
                        ),
                        preferredSize: new Size(double.infinity, 0.0)),
                    // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
                    flexibleSpace: FlexibleSpaceBar(
                        background: FadeInImage.assetNetwork(
                      placeholder: Images.defalutBeauty,
                      image: meiziUrl,
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                new CollectionPage(new ValueKey(0), _controller),
                new CollectionPage(new ValueKey(1), _controller),
              ],
            ),
          ),
          floatingActionButton: Opacity(
            opacity: _isVisible ? 1.0 : 0.0,
            child: FloatingActionButton(
              child: Icon(Icons.pregnant_woman),
              onPressed: () {
                getMeizi();
              },
            ),
          )),
    );
  }

  void getMeizi() async {
    Map<String, String> map = Map();
    map["number"] = "1";
    http.Response res = await http.get(Api.RandomBeautie);
    if (res.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(res.body);
      Category resp = Category.fromJson(responseJson);
      List meizis = resp.results;
      List<Meizi> articles = meizis.map((m) => Meizi.fromJson(m)).toList();
      setState(() {
        this.meiziUrl = articles[0].url;
      });
    } else {
      setState(() {
        this.meiziUrl = DefalutUrl;
      });
    }
  }
}
