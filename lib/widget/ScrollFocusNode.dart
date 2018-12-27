import 'package:flutter/cupertino.dart';

class ScrollFocusNode extends FocusNode {
  final bool _useSystemKeyBoard; // 是否使用系统键盘
  final double _moveValue; // 上移距离

  ScrollFocusNode(this._useSystemKeyBoard, this._moveValue);

  @override
  bool consumeKeyboardToken() {
    if (_useSystemKeyBoard) {
      return super.consumeKeyboardToken();
    }
    return false;
  }

  double get moveValue => _moveValue;

  bool get useSystemKeyBoard => _useSystemKeyBoard;
}