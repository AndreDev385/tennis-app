/*
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({super.key});

  @override
  State<StatefulWidget> createState() => _VideoStream();

  static const route = "video-stream";
}

class _VideoStream extends State<VideoStream> {
  String user = "admin";
  String password = "7eFnH3Q6";

  VlcPlayerController _videoPlayerController = VlcPlayerController.network(
    //'https://media.w3.org/2010/05/sintel/trailer.mp4',
    Uri.parse("rtsp://andre:J2osqcdm.@192.168.0.1:554/stream1").toString(),
    hwAcc: HwAcc.auto,
    options: VlcPlayerOptions(),
  );

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: VlcPlayer(
                controller: _videoPlayerController,
                aspectRatio: 14 / 9,
                placeholder: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: IconButton(
              onPressed: () async {
                bool? isPlaying = await _videoPlayerController.isPlaying();
                if (isPlaying!) {
                  _videoPlayerController.pause();
                } else {
                  _videoPlayerController.play();
                }
              },
              icon: Icon(Icons.pause),
            ),
          )
        ],
      ),
    );
  }
}
*/
