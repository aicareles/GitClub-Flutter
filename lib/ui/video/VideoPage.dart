import 'package:flutter/material.dart';
import 'package:gitclub/ui/video/VideoPlay.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  String url1 = 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4';
  String url2 = 'http://baobab.kaiyanapp.com/api/v1/playUrl?vid=146888&resourceType=video&editionType=default&source=aliyun';
  String url3 = 'http://baobab.kaiyanapp.com/api/v1/playUrl?vid=146196&resourceType=video&editionType=default&source=aliyun';
  String url4 = 'http://baobab.kaiyanapp.com/api/v1/playUrl?vid=146074&resourceType=video&editionType=default&source=aliyun';
  String url5 = 'http://baobab.kaiyanapp.com/api/v1/playUrl?vid=146712&resourceType=video&editionType=default&source=aliyun';
  List<String> _videoUrls = [];

  @override
  void initState() {
    super.initState();
    _videoUrls.add(url1);
    _videoUrls.add(url2);
    _videoUrls.add(url3);
    _videoUrls.add(url4);
    _videoUrls.add(url5);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("视频学习"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 3.0),
            child: NetworkPlayerLifeCycle(
              _videoUrls[index],
              (BuildContext context, VideoPlayerController controller) =>
                  AspectRatioVideo(controller),
            ),
          );
        },
        itemCount: _videoUrls.length,
      ),
    );
  }
}
