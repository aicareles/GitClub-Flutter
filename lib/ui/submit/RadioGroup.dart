import 'package:flutter/material.dart';
import 'package:gitclub/constance/colors.dart';

class RadioGroup<T> extends StatefulWidget {
  List<T> values;
  String groupValue;
//  Function(RadioText radio) onSelectedItem;
  Function(String value) onSelectedItem;

  @override
  State<StatefulWidget> createState() => RadioGroupState();

  RadioGroup(
      {Key key,
      @required this.values,
      @required this.groupValue,
      @required this.onSelectedItem})
      :assert(values != null),
      assert(groupValue != null),
      super(key: key);
}

class RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: groups(),
    );
  }

  List<Widget> groups() {
    List<Widget> childs = List<Widget>();
    for(RadioText radio in widget.values) {
      Widget child = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Radio(
            activeColor: AppColors.colorPrimary,
            value: radio.value,
            groupValue: widget.groupValue,
            onChanged: (value) {
              widget.onSelectedItem(value);
              setState(() {
                widget.groupValue = value;
              });
            },
          ),
          Text(radio.titleValue),
        ],
      );
      childs.add(child);
    }
    return childs;
  }

}


class RadioText {
  String value;
  String titleValue;
  RadioText(this.value, this.titleValue);

}
