import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../widgets/build_video_loader.dart';
import '../widgets/build_video_player.dart';

class FullScreenLessonPage extends StatefulWidget {
  const FullScreenLessonPage({super.key});

  @override
  State<FullScreenLessonPage> createState() => _FullScreenLessonPageState();
}

class _FullScreenLessonPageState extends State<FullScreenLessonPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)?.settings.arguments;
    VideoPlayerController controller = args['controller'];
    String imageUrl = args['imageUrl'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BuildVideoPlayer(
          controller: controller,
          height: double.infinity,
          imageUrl: imageUrl,
          loader: const BuildVideoLoader(height: double.infinity),
          isFullScreen: true,
        ),
      ),
    );
  }
}
