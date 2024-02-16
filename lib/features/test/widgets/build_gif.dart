import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:korkort_test/common/theme/colors.dart';

import '../model/question.dart';

class _GifFrame {
  final ImageInfo imageInfo;
  final Duration duration;

  const _GifFrame(this.imageInfo, this.duration);
}

class BuildGif extends StatefulWidget {
  const BuildGif({super.key, required this.question});

  final Question question;

  @override
  State<BuildGif> createState() => _BuildGifState();
}

class _BuildGifState extends State<BuildGif> {
  List<_GifFrame> frameList = [];
  bool isPlaying = false;
  int currentIndex = 0;

  Future<void> config() async {
    Codec codec = await instantiateImageCodec(
      widget.question.gifBytes!,
      allowUpscaling: false,
    );

    for (var i = 0; i < codec.frameCount; i++) {
      FrameInfo frameInfo = await codec.getNextFrame();
      Duration duration = frameInfo.duration;
      frameList.add(
        _GifFrame(
          ImageInfo(image: frameInfo.image),
          duration,
        ),
      );
    }

    currentIndex = codec.frameCount - 1;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    config();
  }

  void pause() {
    isPlaying = false;
    setState(() {});
  }

  void play() {
    if (currentIndex == frameList.length - 1) {
      currentIndex = 0;
    }

    isPlaying = true;
    setState(() {});
    runNextFrame();
  }

  void run() {
    if (isPlaying) {
      runNextFrame();
    }
  }

  void runNextFrame() async {
    await Future.delayed(frameList[currentIndex].duration);

    if (currentIndex < frameList.length - 1) {
      currentIndex++;
    } else {
      currentIndex = frameList.length - 1;
      isPlaying = false;
    }

    if (mounted) {
      setState(() {});
      run();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height / 4.6;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 24, right: 24),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: frameList.isNotEmpty
                    ? RawImage(
                        image: frameList[currentIndex].imageInfo.image,
                        height: height,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(height: height),
              ),
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: IconButton(
                onPressed: () {
                  if (isPlaying) {
                    pause();
                  } else {
                    play();
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: kkColorPrimary,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
