import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gitclub/widget/Toast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key key, this.url}) : super(key: key);
  final url;

  @override
  State<StatefulWidget> createState() {
    return PhotoPageState();
  }
}

class PhotoPageState extends State<PhotoPage>
    with SingleTickerProviderStateMixin {

  static const platform =
  const MethodChannel('gitclub.com.wallpaper/wallpaper');

  AnimationController _controller;
  Animation<Offset> _animation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;
  double _kMinFlingVelocity = 600.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      setState(() {
        _offset = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    // widget的屏幕宽度
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    // 限制他的最小尺寸
    return Offset(
        offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // 计算图片放大后的位置
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 3.0);
      // 限制放大倍数 1~3倍
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
      // 更新当前位置
    });
  }

  void _handleOnDoubleTap() {
    if (_scale > 1.3) {
      //还原
      setState(() {
        _scale = 1.0;
        _offset = Offset.fromDirection(0.5);
      });
    } else {
      //放大1.5
      setState(() {
        _scale = 1.5;
        _offset = Offset.fromDirection(0.5);
      });
    }
  }

  void _onImageSaveButtonPressed() async {
    showLoading();
    Dio dio = Dio();
    var appDocDir = await getApplicationDocumentsDirectory();
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    File file = new File(appDocDir.path + "/" + imageName);
    if (!await file.exists()) {
      file = await file.create();
    }
    await dio.download(widget.url, file.path, onProgress: (progress, total) {
      if (progress == total) {
        Timer(Duration(seconds: 1),(){
          Toast.toast(context, "保存成功");
          Navigator.pop(context);
        });
      }
    });
  }

  Future<Null> setWallpaper() async {
    showLoading();
    Dio dio = Dio();
    try {
      var dir = await getTemporaryDirectory();
      print(dir);

      await dio.download(widget.url, "${dir.path}/myimage.jpeg",
          onProgress: (progress, total) {
            if (progress == total) {
              _setWallpaer();
            }
          });
    } catch (e) {
      Toast.toast(context, "Failed to Set Wallpaer: '${e.message}'");
      Navigator.pop(context);
    }
  }

  Future<Null> _setWallpaer() async {
    try {
      final int result =
      await platform.invokeMethod('setWallpaper', 'myimage.jpeg');
      if(result == 0) {
        Timer(Duration(seconds: 1),(){
          Navigator.pop(context);
          Toast.toast(context, "设置壁纸成功");
        });
      }
    } on PlatformException catch (e) {
      Toast.toast(context, "Failed to Set Wallpaer: '${e.message}'");
      Navigator.pop(context);
    }
  }

  void showLoading(){
    Navigator.pop(context);
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpinKitRotatingCircle(
            color: Colors.white,
            size: 50.0,
          );
        });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    // 计算当前的方向
    final double distance = (Offset.zero & context.size).shortestSide;
    // 计算放大倍速，并相应的放大宽和高，比如原来是600*480的图片，放大后倍数为1.25倍时，宽和高是同时变化的
    _animation = _controller.drive(Tween<Offset>(
        begin: _offset, end: _clampOffset(_offset + direction * distance)));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      onTap: () {
        Navigator.pop(context);
      },
//      onDoubleTap: _handleOnDoubleTap,
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: <Widget>[
                  ListTile(
                    title: Text("保存到本地"),
                    onTap: () {
                      _onImageSaveButtonPressed();
                    },
                  ),
                  ListTile(
                    title: Text("设置为壁纸"),
                    onTap: () {
                      setWallpaper();
                    },
                  ),
                ],
              );
            });
      },
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.network(
            widget.url,
            fit: BoxFit.cover,
          ),
        ),
        // child: Image.network(widget.url,fit: BoxFit.cover,),
      ),
    );
  }
}
