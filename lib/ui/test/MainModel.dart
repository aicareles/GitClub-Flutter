import 'package:scoped_model/scoped_model.dart';

//class MainModel extends Model with BaseModel, TestModel, Test2Model{
//
//
//  MainModel();
//}

class BaseModel extends Model {}

class TestModel extends BaseModel {
  int _count = 0;

  get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class Test2Model extends BaseModel {
  int _count = 0;

  get count => _count;

  void reduce() {
    _count--;
    notifyListeners();
  }
}


