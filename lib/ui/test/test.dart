import 'package:flutter/material.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/ui/test/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage> {

  List<Article> articles = List<Article>();
  TestModel testModel = TestModel();

  @override
  void initState() {
    super.initState();
    articles = ArticleFactory.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    final testModel = ScopedModel.of<TestModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('测试界面')),
//      body: _body(),
      body: Center(
        child: Text(
            testModel.count.toString()
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            Icons.keyboard_arrow_right
        ),
        onPressed: (){
          Navigator.pushNamed(context, "/test2");
        },
      ),
    );
  }

  Widget _row1(int index) => Row(
    children: <Widget>[
      Expanded(
        child: Row(
          children: <Widget>[
            ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: Images.defalutHomeListAvatar,
                fit: BoxFit.fitWidth,
                image: articles[index].avatar,
                width: 30.0,
                height: 30.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                articles[index].name,
                style: TextStyle(color: AppColors.colorPrimary),
              ),
            ),
          ],
        ),
      ),
      Text(
        articles[index].time,
      ),
    ],
  );

  Widget _row2(int index) => Row(
    children: <Widget>[
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            articles[index].title,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 20.0
            ),
          ),
        )
      )
    ],
  );

  Widget _row3(int index) => Row(
    children: <Widget>[
      Expanded(
        child: Image.network(
            articles[index].imageLink
        ),
      ),
    ],
  );

  Widget _row4(int index) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Row(
        children: <Widget>[
          Icon(
            Icons.remove_red_eye,
            color: Colors.black12,
          ),
          Text(
            articles[index].views.toString(),
            style: TextStyle(
              color: Colors.black12
            ),
          )
        ],
      ),
      Row(
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.black12,
          ),
          Text(
            articles[index].stars.toString(),
            style: TextStyle(
                color: Colors.black12
            ),
          )
        ],
      ),
    ],
  );

  Widget _body() => ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          child: InkWell(
            child: item(index),
          ),
        );
      },
      itemCount: articles.length
  );

  Widget item(int index) => Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _row1(index),
          ),
          _row2(index),
          _row3(index),
          _row4(index),
        ],
      );

}


class Article {
  String avatar;
  String name;
  String time;
  String title;
  String imageLink;
  int views;
  int stars;

  Article(this.avatar, this.name, this.time, this.title, this.imageLink,
      this.views, this.stars);

}

class ArticleFactory {
  static List<Article> articles = [
  new Article('https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKcic2gFRKkviaUms4yyubejrkqJupMwHXBZKzydgr76FReUJ4Zv5qIxeCdQMxJW0aqOQ0lsNTm4LibQ/132',
  'ca!','2018-09-12','Flutter为何如此强大!',
  'https://gitclub.502tech.com/GitClub/image/3FD940BB3AFE4E5C82E91CF8F7893675.gif?Expires=1860544898&OSSAccessKeyId=LTAI4KXTQGO5UMVQ&Signature=D80ho5dQ0peCM3Z3EVo%2FTsX3Bhw%3D',
  12,23),
  new Article('https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKcic2gFRKkviaUms4yyubejrkqJupMwHXBZKzydgr76FReUJ4Zv5qIxeCdQMxJW0aqOQ0lsNTm4LibQ/132',
  'ca!','2018-09-12','Flutter为何如此强大!',
  'https://gitclub.502tech.com/GitClub/image/3FD940BB3AFE4E5C82E91CF8F7893675.gif?Expires=1860544898&OSSAccessKeyId=LTAI4KXTQGO5UMVQ&Signature=D80ho5dQ0peCM3Z3EVo%2FTsX3Bhw%3D',
  12,23),
  new Article('https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKcic2gFRKkviaUms4yyubejrkqJupMwHXBZKzydgr76FReUJ4Zv5qIxeCdQMxJW0aqOQ0lsNTm4LibQ/132',
  'ca!','2018-09-12','Flutter为何如此强大!',
  'https://gitclub.502tech.com/GitClub/image/3FD940BB3AFE4E5C82E91CF8F7893675.gif?Expires=1860544898&OSSAccessKeyId=LTAI4KXTQGO5UMVQ&Signature=D80ho5dQ0peCM3Z3EVo%2FTsX3Bhw%3D',
  12,23),
  new Article('https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKcic2gFRKkviaUms4yyubejrkqJupMwHXBZKzydgr76FReUJ4Zv5qIxeCdQMxJW0aqOQ0lsNTm4LibQ/132',
  'ca!','2018-09-12','Flutter为何如此强大!',
  'https://gitclub.502tech.com/GitClub/image/3FD940BB3AFE4E5C82E91CF8F7893675.gif?Expires=1860544898&OSSAccessKeyId=LTAI4KXTQGO5UMVQ&Signature=D80ho5dQ0peCM3Z3EVo%2FTsX3Bhw%3D',
  12,23),
  new Article('https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKcic2gFRKkviaUms4yyubejrkqJupMwHXBZKzydgr76FReUJ4Zv5qIxeCdQMxJW0aqOQ0lsNTm4LibQ/132',
  'ca!','2018-09-12','Flutter为何如此强大!',
  'https://gitclub.502tech.com/GitClub/image/3FD940BB3AFE4E5C82E91CF8F7893675.gif?Expires=1860544898&OSSAccessKeyId=LTAI4KXTQGO5UMVQ&Signature=D80ho5dQ0peCM3Z3EVo%2FTsX3Bhw%3D',
  12,23),
  ];
  static getArticles() {
    List<Article> lists = List<Article>();
    return lists..addAll(articles)..addAll(articles)..addAll(articles);
  }
}
