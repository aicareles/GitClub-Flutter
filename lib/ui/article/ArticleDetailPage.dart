import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gitclub/constance/Constants.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';

//文章详情界面
class ArticleDetailPage extends StatefulWidget {
  String title;
  String url;
  String article_id;

  ArticleDetailPage({
    Key key,
    @required this.title,
    @required this.url,
    @required this.article_id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleDetailPageState();
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
  bool isLoad = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    viewArticle();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(widget.title),
        bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: isLoad
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  )),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }

  void viewArticle() {
    Map<String, String> map = new Map();
    map[Parms.ARTICLE_ID] = widget.article_id.toString();
    HttpUtil.post(Api.VIEW_ARTICLE, (data) {},params: map);
  }
}
