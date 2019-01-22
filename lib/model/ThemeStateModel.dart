import 'dart:ui';

import 'package:scoped_model/scoped_model.dart';

class ThemeStateModel extends Model {

  Color _color;
  get color => _color;

  void changeTheme(Color color) async {
    _color = color;
    notifyListeners();
  }

  ThemeStateModel of(context) =>
      ScopedModel.of<ThemeStateModel>(context);
}