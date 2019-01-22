import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/http/Api.dart';
import 'package:gitclub/http/HttpUtil.dart';
import 'package:gitclub/ui/submit/RadioGroup.dart';
import 'package:gitclub/widget/Loading.dart';
import 'package:gitclub/widget/ScrollFocusNode.dart';
import 'package:gitclub/widget/Toast.dart';
import 'package:image_picker/image_picker.dart';

class SubmitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SubmitPageState();
}

class SubmitPageState extends State<SubmitPage> with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _desController = new TextEditingController();
  TextEditingController _linkController = new TextEditingController();
  TextEditingController _imgController = new TextEditingController();
  final ScrollController _controller = ScrollController();
  ScrollFocusNode _focusNode;
  File _image;
  List<RadioText> languageValues = List<RadioText>();
  List<RadioText> typeValues = List<RadioText>();
  List<RadioText> rankValues = List<RadioText>();
  String _languageValue = 'Android';
  String _typeValue = '0';
  String _rankValue = '0';

  double _currentPosition = 0.0;

  void bindNewInputer(ScrollFocusNode focusNode) {
    _focusNode = focusNode;
    _animateUp();
  }

  @override
  void initState() {
    super.initState();
    initLanguageValues();
    initRankValues();
    initTypeValues();
    WidgetsBinding.instance.addObserver(this);
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void initTypeValues() {
    typeValues.add(RadioText('0', allTranslations.text('library')));
    typeValues.add(RadioText('1', allTranslations.text('news')));
    typeValues.add(RadioText('2', allTranslations.text('guide')));
    typeValues.add(RadioText('3', allTranslations.text('book')));
    typeValues.add(RadioText('4', allTranslations.text('tool')));
    typeValues.add(RadioText('5', allTranslations.text('app')));
    typeValues.add(RadioText('6', allTranslations.text('active')));
    typeValues.add(RadioText('7', allTranslations.text('jobs')));
  }

  void initRankValues() {
    rankValues.add(RadioText('0', allTranslations.text('all')));
    rankValues.add(RadioText('1', allTranslations.text('elementary')));
    rankValues.add(RadioText('2', allTranslations.text('advanced')));
  }

  void initLanguageValues() {
    languageValues.add(RadioText('Android', 'Android'));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  //  向上滚动
  void _animateUp() {
    _controller
        .animateTo(_focusNode.moveValue,
            duration: Duration(milliseconds: 250), curve: Curves.easeOut)
        .then((Null) {
      _currentPosition = _controller.offset;
    });
  }

  //  向下滚动
  void _animateDown() {
    _controller
        .animateTo(0.0,
            duration: Duration(milliseconds: 250), curve: Curves.easeOut)
        .then((Null) {
      _currentPosition = 0.0;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    _uploadImg();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(allTranslations.text('submission')),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: bodyData(),
      ),
    );
  }

  Widget language() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RadioGroup(
            values: languageValues,
            groupValue: _languageValue,
            onSelectedItem: (String value) {
              _languageValue = value;
            },
          )
        ],
      );

  Widget type() => Column(
        children: <Widget>[
          RadioGroup(
            values: typeValues,
            groupValue: _typeValue,
            onSelectedItem: (String value) {
              _typeValue = value;
            },
          )
        ],
      );

  Widget rank() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RadioGroup(
            values: rankValues,
            groupValue: _rankValue,
            onSelectedItem: (String value) {
              _rankValue = value;
            },
          )
        ],
      );

  Widget bodyData() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title(allTranslations.text('language')),
          language(),
          title(allTranslations.text('sorts')),
          type(),
          title(allTranslations.text('suitable')),
          rank(),
          fillEntries(),
          _image == null ? add() : photo(),
          submit()
        ],
      );

  Widget title(var title) => Padding(
        padding: EdgeInsets.only(left: 15.0, top: 10.0),
        child: Text(
          title,
          style: TextStyle(
              color: AppColors.colorPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      );

  Widget submit() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      MaterialButton(
        minWidth: 300.0,
        child: Text(
          allTranslations.text('submit'),
          style: TextStyle(color: AppColors.textWhite),
        ),
        color: AppColors.colorPrimary,
        onPressed: () {
          setState(() {
            submitArticle();
            _uploadArticle();
          });
        },
      )
    ],
  );

  void submitArticle() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            //调用对话框
            text: allTranslations.text('submitting_article'),
          );
//        return SpinKitRotatingCircle(
//          color: Colors.white,
//          size: 50.0,
//        );
        });
  }

  Widget add() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      RaisedButton(
        child: Icon(
          Icons.filter,
          size: 80.0,
        ),
        onPressed: () {
          getImage();
        },
      )
    ],
  );

  Widget photo() => GestureDetector(
        child: Image.file(
          _image,
          width: 200.0,
          height: 200.0,
          fit: BoxFit.fill,
        ),
        onTap: () {
          getImage();
        },
      );

  Widget fillEntries() => Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              maxLength: 100,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.title,
                    size: 15.0,
                  ),
                  labelText: allTranslations.text('title_hint'),
                  labelStyle: TextStyle(color: AppColors.textHint),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
            TextField(
              controller: _desController,
              keyboardType: TextInputType.text,
              maxLength: 140,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.description,
                    size: 15.0,
                  ),
                  labelStyle: TextStyle(color: AppColors.textHint),
                  labelText: allTranslations.text('des_hint'),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
            TextField(
              controller: _linkController,
              keyboardType: TextInputType.text,
              maxLength: 140,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.link,
                    size: 15.0,
                  ),
                  labelStyle: TextStyle(color: AppColors.textHint),
                  labelText: allTranslations.text('link_hint'),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
            TextField(
              controller: _imgController,
              keyboardType: TextInputType.text,
              maxLength: 240,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.photo,
                    size: 15.0,
                  ),
                  labelStyle: TextStyle(color: AppColors.textHint),
                  labelText: allTranslations.text('image_hint'),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
          ],
        ),
      );

  //  使用系统键盘 ---> 矩阵变换 ---> 返回原位置
  @override
  void didChangeMetrics() {
    if (_currentPosition != 0.0) {
      _focusNode.unfocus(); // 如果不加，收起键盘再点击会默认键盘还在。
      _animateDown();
    }
  }

  //上传图片
  void _uploadImg() {
    String url = Api.UPLOAD_ARTICLE_IMG;
    HttpUtil.uploadFile(url, _image, (data) {
      if (data != null) {
        Toast.toast(context, allTranslations.text('upload_image_success'));
        _imgController.text = data['article_img'];
      }
    }, errorCallback: (msg) {
      scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(msg)));
    });
  }

  //上传文章
  void _uploadArticle() {
    String url = Api.UPLOAD_ARTICLE;
    Map<String, String> map = new Map();
    map["title"] = _titleController.text;
    map["des"] = _desController.text;
    map["contributor_id"] = '3';
    map["link"] = _linkController.text;
    map["category"] = _languageValue;
    map["child_category"] = _typeValue;
    map["rank"] = _rankValue;
    map["img_url"] = _imgController.text;
    HttpUtil.post(
        url,
        (data) {
          if (data != null) {
            hideDialog();
            Toast.toast(context, allTranslations.text('upload_article_success'));
            Navigator.pop(context);
          }
        },
        params: map,
        errorCallback: (msg) {
          Navigator.pop(context);
          scaffoldKey.currentState
              .showSnackBar(new SnackBar(content: new Text(msg)));
        });
  }

  void hideDialog() {
    Navigator.pop(context);
  }
}
