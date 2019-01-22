import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/ui/meizi/Category.dart';
import 'package:gitclub/ui/meizi/PhotoPage.dart';
import 'package:gitclub/widget/Toast.dart';
import 'package:http/http.dart' as http;

class BeautiesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BeautiesPageState();
}

class BeautiesPageState extends State<BeautiesPage> {
  List<Meizi> listData = new List<Meizi>();

  @override
  void initState() {
    super.initState();
    getMeizis();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(allTranslations.text('lucky')),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0, //主轴(竖直)方向间距
              crossAxisSpacing: 10.0, //纵轴(水平)方向间距
              childAspectRatio: 1.0 //纵轴缩放比例
              ),
          itemCount: listData.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                child: Image.network(
                  listData[index].url,
                  fit: BoxFit.fitWidth,
                ),
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                    return new PhotoPage(
                      url: listData[index].url,
                    );
                  }));
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pregnant_woman),
        onPressed: () {
          getMeizis();
        },
      ),
    );
  }

  void getMeizis() async {
    http.Response res = await http.get(Api.RandomBeauties);
    if (res.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(res.body);
      Category resp = Category.fromJson(responseJson);
      List meizis = resp.results;
      List<Meizi> articles = meizis.map((m) => Meizi.fromJson(m)).toList();
      setState(() {
        this.listData = articles;
      });
    } else {
      Toast.toast(context, allTranslations.text('loading_failed'));
    }
  }
}
