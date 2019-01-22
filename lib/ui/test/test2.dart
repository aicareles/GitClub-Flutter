import 'package:flutter/material.dart';
import 'package:gitclub/ui/test/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Test2Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Test2PageState();
}

class Test2PageState extends State<Test2Page> {
  @override
  Widget build(BuildContext context) {
//    final testModel = ScopedModel.of<TestModel>(context);
    return ScopedModelDescendant<TestModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('test2'),
          ),
          body: Center(
            child: Text(model.count.toString()),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(
                  Icons.add
              ),
              onPressed: () {
                model.increment();
              }),
        );
      },
    );
  }
}
