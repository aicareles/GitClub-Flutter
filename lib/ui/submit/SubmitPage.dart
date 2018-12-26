import 'package:flutter/material.dart';
import 'package:gitclub/constance/colors.dart';

class SubmitPage extends StatelessWidget {

  TextEditingController _submitController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('投稿'),
      ),
      body: bodyData(),
    );
  }

  Widget bodyData() => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10.0,
              ),
              Text('分类:'),
              Radio (
                activeColor: AppColors.colorPrimary,
                value: 'Android',
                groupValue: 'Android', onChanged: (String value) {},
              ),
              Text('Android'),
            ],
          ),
          Row(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10.0,
              ),
              Text('适用:'),
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
          ),
          fillEntries(),
        ],
      );

  Widget fillEntries() => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TextField(
        controller: _submitController,
        keyboardType: TextInputType.number,
        maxLength: 19,
//        style: TextStyle(
//            fontFamily: UIData.ralewayFont, color: Colors.black),
//        onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
        decoration: InputDecoration(
            labelText: "Credit Card Number",
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            border: OutlineInputBorder()),
      ),
      TextField(
        controller: _submitController,
        keyboardType: TextInputType.number,
        maxLength: 5,
//        style: TextStyle(
//            fontFamily: UIData.ralewayFont, color: Colors.black),
//        onChanged: (out) => cardBloc.expInputSink.add(expMask.text),
        decoration: InputDecoration(
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            labelText: "MM/YY",
            border: OutlineInputBorder()),
      ),
      TextField(
        keyboardType: TextInputType.number,
        maxLength: 3,
//        style: TextStyle(
//            fontFamily: UIData.ralewayFont, color: Colors.black),
//        onChanged: (out) => cardBloc.cvvInputSink.add(out),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelText: "CVV",
            border: OutlineInputBorder()),
      ),
      TextField(
        keyboardType: TextInputType.text,
        maxLength: 20,
//        style: TextStyle(
//            fontFamily: UIData.ralewayFont, color: Colors.black),
//        onChanged: (out) => cardBloc.nameInputSink.add(out),
        decoration: InputDecoration(
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            labelText: "Name on card",
            border: OutlineInputBorder()),
      ),
    ],
  );
}
