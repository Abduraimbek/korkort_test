import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../controller/video_controller.dart';
import 'build_video_player.dart';

class BuildVideoPlayerControllerWrapper extends ConsumerStatefulWidget {
  const BuildVideoPlayerControllerWrapper({
    super.key,
    required this.videoUrl,
    required this.imageUrl,
    required this.height,
    required this.loader,
  });

  final String videoUrl;
  final String imageUrl;
  final double height;
  final Widget loader;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BuildVideoPlayerControllerWrapperState();
}

class _BuildVideoPlayerControllerWrapperState
    extends ConsumerState<BuildVideoPlayerControllerWrapper> {
  late VideoPlayerController controller;

  void listener() {
    ref.read(videoControllerProvider.notifier).setControllerState(
          isPlaying: controller.value.isPlaying,
          isInitialized: controller.value.isInitialized,
          position: controller.value.position,
          duration: controller.value.duration,
        );
  }

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    controller.initialize();
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      color: Colors.black,
      child: BuildVideoPlayer(
        controller: controller,
        imageUrl: widget.imageUrl,
        height: widget.height,
        loader: widget.loader,
      ),
    );
  }
}
