import 'package:flutter/material.dart';
import 'package:gitclub/ui/my/CollectionPage.dart';

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PersonPageState();
  }
}

class PersonPageState extends State<PersonPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  title: Text('艾神一不小心'),
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
                          Tab(text: '收藏'),
                          Tab(text: '贡献'),
                        ],
                      ),
                      color: Colors.blue,
                    ),
                      preferredSize: new Size(double.infinity, 0.0)
                  ),
                  // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                        "http://pic1.win4000.com/pic/4/f8/1402e4b05e.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              new CollectionPage(new ValueKey(0)),
              new CollectionPage(new ValueKey(1)),
            ],
          ),
        ),
      ),
    );
  }
}