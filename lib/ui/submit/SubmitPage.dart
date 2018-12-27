import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:gitclub/widget/Loading.dart';
import 'package:gitclub/widget/ScrollFocusNode.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubmitPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SubmitPageState();
}

class SubmitPageState extends State<SubmitPage> with WidgetsBindingObserver{

  TextEditingController _submitController = new TextEditingController();
  final ScrollController _controller = ScrollController();
  ScrollFocusNode _focusNode;
  File _image;

  double _currentPosition = 0.0;

  void bindNewInputer(ScrollFocusNode focusNode) {
    _focusNode = focusNode;
    _animateUp();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('投稿'),
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
      Radio (
        activeColor: AppColors.colorPrimary,
        value: 'Android',
        groupValue: 'Android', onChanged: (String value) {},
      ),
      Text('Android'),
    ],
  );

  Widget type() => Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio (
            activeColor: AppColors.colorPrimary,
            value: '开源库',
            groupValue: '开源库', onChanged: (String value) {},
          ),
          Text('开源库'),
          Radio (
            activeColor: AppColors.colorPrimary,
            value: '资讯',
            groupValue: '资讯', onChanged: (String value) {},
          ),
          Text('资讯'),
          Radio (
            activeColor: AppColors.colorPrimary,
            value: '教程',
            groupValue: '教程', onChanged: (String value) {},
          ),
          Text('教程'),
          Radio (
            activeColor: AppColors.colorPrimary,
            value: '书籍',
            groupValue: '书籍', onChanged: (String value) {},
          ),
          Text('书籍'),
        ],
      ),
      Row(
        children: <Widget>[
          Radio (
            activeColor: AppColors.colorPrimary,
            value: '工具',
            groupValue: '工具', onChanged: (String value) {},
          ),
          Text('工具'),
          Radio (
            activeColor: AppColors.colorPrimary,
            value: 'APP',
            groupValue: 'APP', onChanged: (String value) {},
          ),
          Text('APP'),
          Radio (
            activeColor: AppColors.colorPrimary,
            value: '活动',
            groupValue: '活动', onChanged: (String value) {},
          ),
          Text('活动'),
          Radio (
            activeColor: AppColors.colorPrimary,
            value: '招聘',
            groupValue: '招聘', onChanged: (String value) {},
          ),
          Text('招聘'),
        ],
      ),
    ],
  );

  Widget suitable() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio (
        activeColor: AppColors.colorPrimary,
        value: '所有人',
        groupValue: '所有人', onChanged: (String value) {},
      ),
      Text('所有人'),
      Radio (
        activeColor: AppColors.colorPrimary,
        value: '入门',
        groupValue: '入门', onChanged: (String value) {},
      ),
      Text('入门'),
      Radio (
        activeColor: AppColors.colorPrimary,
        value: '进阶',
        groupValue: '进阶', onChanged: (String value) {},
      ),
      Text('进阶'),
    ],
  );

  Widget bodyData() => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      title('语言'),
      language(),
      title('分类'),
      type(),
      title('适合人群'),
      suitable(),
      fillEntries(),
      _image == null ? add() : photo(),
      submit()
    ],
  );

  Widget title(var title) => Padding(
    padding: EdgeInsets.only(left: 15.0, top: 10.0),
    child: Text(title, style: TextStyle(
        color: AppColors.colorPrimary,
        fontSize: 18.0,
        fontWeight: FontWeight.bold
    ),),
  );

  Widget submit() => MaterialButton(
    child: Text('提交'),
    color: AppColors.colorPrimary,
    onPressed: (){
      setState(() {
        submitArticle();
      });
    },
  );

  void submitArticle() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: '正在提交文章...',
          );
//        return SpinKitRotatingCircle(
//          color: Colors.white,
//          size: 50.0,
//        );
        });
  }

//  Navigator.pop(context); //关闭对话框

  Widget add() => RaisedButton(
    child: Text('选择图片'),
    onPressed: (){
      getImage();
    },
  );

  Widget photo() => Image.file(
      _image,
    width: 200.0,
    height: 200.0,
    fit: BoxFit.fill,
  );

  Widget fillEntries() => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TextField(
        controller: _submitController,
        keyboardType: TextInputType.text,
        maxLength: 100,
        decoration: InputDecoration(
            labelText: "标题,<100字",
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            border: OutlineInputBorder()),
      ),
      TextField(
        controller: _submitController,
        keyboardType: TextInputType.text,
        maxLength: 140,
        decoration: InputDecoration(
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            labelText: "描述,<140字",
            border: OutlineInputBorder()),
      ),
      TextField(
        keyboardType: TextInputType.text,
        maxLength: 140,
        decoration: InputDecoration(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelText: "链接,原文地址",
            border: OutlineInputBorder()),
      ),
      TextField(
        keyboardType: TextInputType.text,
        maxLength: 140,
        decoration: InputDecoration(
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            labelText: "图片，插入链接或上传本地图片",
            border: OutlineInputBorder()),
      ),
    ],
  );

  //  使用系统键盘 ---> 矩阵变换 ---> 返回原位置
  @override
  void didChangeMetrics() {
    if (_currentPosition != 0.0) {
      _focusNode.unfocus(); // 如果不加，收起键盘再点击会默认键盘还在。
      _animateDown();
    }
  }
}