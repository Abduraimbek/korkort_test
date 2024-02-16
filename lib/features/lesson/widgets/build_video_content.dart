import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/lesson_controller.dart';
import 'build_video_player_controller_wrapper.dart';

class BuildVideoContent extends ConsumerWidget {
  const BuildVideoContent({
    super.key,
    required this.height,
    required this.loader,
  });

  final double height;
  final Widget loader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(lessonControllerProvider);

    if (lessonState.isFetching) {
      return loader;
    }

    if (lessonState.lesson != null) {
      return BuildVideoPlayerControllerWrapper(
        videoUrl: lessonState.lesson!.video,
        imageUrl: lessonState.lesson!.image,
        height: height,
        loader: loader,
      );
    }

    return Container(
      width: double.infinity,
      height: height,
      color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          Text('${lessonState.error}'),
        ],
      ),
    );
  }
}
