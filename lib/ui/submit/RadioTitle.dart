import 'package:flutter/material.dart';
import 'package:gitclub/constance/colors.dart';

class RadioTitle<T> extends StatefulWidget {

  String title;
  T value;
  T groupValue;
  Function(T value) onChanged;

  @override
  State<StatefulWidget> createState() => RadioTitleState();

  RadioTitle({Key key, this.title, this.value,@required this.groupValue, @required this.onChanged}) : super(key:key);
}

class RadioTitleState<T> extends State<RadioTitle> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Radio(
          activeColor: AppColors.colorPrimary,
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: (value){
            widget.onChanged(value);
          },
        ),
        Text(widget.title),
      ],
    );
  }
}
