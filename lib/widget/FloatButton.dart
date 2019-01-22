import 'package:flutter/material.dart';
import 'package:gitclub/constance/colors.dart';

class FancyFab extends StatefulWidget {
  final Function() onSubmitPressed;
  final Function() onPersonPressed;

  FancyFab({Key key, this.onSubmitPressed, this.onPersonPressed})
      : super(key: key); //  FancyFab({this.onPressed, this.tooltip, this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: AppColors.colorPrimary,
      end: AppColors.colorPrimary,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget submit() {
    return Container(
      child: FloatingActionButton(
        onPressed: widget.onSubmitPressed,
        tooltip: 'submit',
        child: Icon(Icons.add_circle),
        heroTag: null,
      ),
    );
  }

//  Widget image() {
//    return Container(
//      child: FloatingActionButton(
//        onPressed: null,
//        tooltip: 'Image',
//        child: Icon(Icons.image),
//        heroTag: null,
//      ),
//    );
//  }

  Widget person() {
    return Container(
      child: FloatingActionButton(
        onPressed: widget.onPersonPressed,
        tooltip: 'person',
        child: Icon(Icons.person),
        heroTag:
            null, //这里必须返回空，不然页面跳转的时候会出错  There are multiple heroes that share the same tag within a subtree
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: submit(),
        ),
//        Transform(
//          transform: Matrix4.translationValues(
//            0.0,
//            _translateButton.value * 2.0,
//            0.0,
//          ),
//          child: image(),
//        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: person(),
        ),
        toggle(),
      ],
    );
  }
}
