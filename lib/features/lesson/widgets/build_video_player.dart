import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../controller/video_controller.dart';

class BuildVideoPlayer extends ConsumerWidget {
  const BuildVideoPlayer({
    super.key,
    required this.controller,
    required this.imageUrl,
    required this.height,
    required this.loader,
    this.isFullScreen = false,
  });

  final VideoPlayerController controller;
  final String imageUrl;
  final double height;
  final Widget loader;
  final bool isFullScreen;

  void hideControlls(WidgetRef ref) {
    ref.read(videoControllerProvider.notifier).hideControlls();
  }

  void showControlls(WidgetRef ref) {
    ref.read(videoControllerProvider.notifier).showControlls();
  }

  void seekBackPressed(WidgetRef ref) {
    ref.read(videoControllerProvider.notifier).hideControllsWithTimer();
    controller.seekTo(controller.value.position - const Duration(seconds: 15));
  }

  void seekForwardPressed(WidgetRef ref) {
    ref.read(videoControllerProvider.notifier).hideControllsWithTimer();
    controller.seekTo(controller.value.position + const Duration(seconds: 15));
  }

  void onSeek(Duration position, WidgetRef ref) {
    ref.read(videoControllerProvider.notifier).hideControllsWithTimer();
    controller.seekTo(position);
  }

  void togglePlayButton(WidgetRef ref) {
    ref.read(videoControllerProvider.notifier).hideControllsWithTimer();
    ref.read(videoControllerProvider.notifier).setStartPressed();
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  void toggleFullScreen(BuildContext context) {
    if (isFullScreen) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushNamed(
        '/fullScreenLesson',
        arguments: {
          'controller': controller,
          'imageUrl': imageUrl,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoControllerProvider);

    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 50),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: !state.isStartPressed && !state.isPlaying
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: height,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) {
                      return Container(color: Colors.black);
                    },
                  )
                : Hero(
                    tag: 'player_hero_tag',
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        height: controller.value.size.height,
                        width: controller.value.size.width,
                        child: VideoPlayer(controller),
                      ),
                    ),
                  ),
          ),
        ),
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 50),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: state.isShowingControlls || !state.isStartPressed
                ? GestureDetector(
                    onTap: () => hideControlls(ref),
                    child: Container(
                      width: double.infinity,
                      height: height,
                      color: Colors.black.withOpacity(0.3),
                      alignment: Alignment.center,
                      child: _BuildControlls(
                        isPlaying: state.isPlaying,
                        isInitialized: state.isInitialized,
                        onToggle: () => togglePlayButton(ref),
                        seekBackPressed: () => seekBackPressed(ref),
                        seekForwardPressed: () => seekForwardPressed(ref),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => showControlls(ref),
                    child: Container(
                      width: double.infinity,
                      height: height,
                      color: Colors.transparent,
                    ),
                  ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: state.isShowingControlls
              ? _BuildProgress(
                  state: state,
                  onSeek: (position) => onSeek(position, ref),
                  isFullScreen: isFullScreen,
                  toggleFullScreen: () => toggleFullScreen(context),
                )
              : const SizedBox.shrink(),
        ),
        if (!state.isShowingControlls && !isFullScreen)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: false,
            ),
          ),
      ],
    );
  }
}

class _BuildControlls extends StatelessWidget {
  const _BuildControlls({
    required this.isPlaying,
    required this.isInitialized,
    required this.onToggle,
    required this.seekBackPressed,
    required this.seekForwardPressed,
  });

  final bool isPlaying;
  final bool isInitialized;
  final VoidCallback onToggle;
  final VoidCallback seekBackPressed;
  final VoidCallback seekForwardPressed;

  @override
  Widget build(BuildContext context) {
    const double height = 72;
    const double smHeight = 33;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: isInitialized ? seekBackPressed : null,
          icon: SvgPicture.asset(
            'assets/svg/seek_back.svg',
            height: smHeight,
            width: smHeight,
          ),
        ),
        SizedBox(
          width: height,
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: onToggle,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                child: Container(
                  width: height,
                  height: height,
                  color: Colors.black.withOpacity(0.24),
                  alignment: Alignment.center,
                  child: isInitialized
                      ? Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 40,
                        )
                      : CircularProgressIndicator(
                          color: Colors.white.withOpacity(.2),
                        ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: isInitialized ? seekForwardPressed : null,
          icon: SvgPicture.asset(
            'assets/svg/seek_forward.svg',
            height: smHeight,
            width: smHeight,
          ),
        ),
      ],
    );
  }
}

class _BuildProgress extends StatelessWidget {
  const _BuildProgress({
    required this.state,
    required this.onSeek,
    required this.isFullScreen,
    required this.toggleFullScreen,
  });

  final VideoState state;
  final Function(Duration) onSeek;
  final bool isFullScreen;
  final VoidCallback toggleFullScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 7, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: Icon(
                  state.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                ),
              ),
              IconButton(
                onPressed: toggleFullScreen,
                color: Colors.white,
                icon: Icon(
                  isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
          child: ProgressBar(
            onSeek: onSeek,
            progress: state.position,
            total: state.duration,
            progressBarColor: const Color(0xFFF1814A),
            thumbColor: const Color(0xFFF1814A),
            thumbRadius: 9,
            barHeight: 4,
            baseBarColor: Colors.white,
            timeLabelTextStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              height: 1.21,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
