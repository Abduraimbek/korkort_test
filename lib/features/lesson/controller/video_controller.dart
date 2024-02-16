import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_controller.freezed.dart';
part 'video_controller.g.dart';

@riverpod
class VideoController extends _$VideoController {
  Timer? _timer;

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  VideoState build() {
    ref.onDispose(_cancelTimer);

    return const VideoState(
      isStartPressed: false,
      isInitialized: false,
      isPlaying: false,
      isShowingControlls: false,
      position: Duration.zero,
      duration: Duration.zero,
    );
  }

  void hideControllsWithTimer() {
    _cancelTimer();
    _timer = Timer(const Duration(milliseconds: 4000), () {
      if (state.isPlaying) {
        state = state.copyWith(isShowingControlls: false);
      }
    });
  }

  void showControlls() {
    if (!state.isShowingControlls) {
      state = state.copyWith(isShowingControlls: true);
      hideControllsWithTimer();
    }
  }

  void hideControlls() {
    if (state.isShowingControlls) {
      _cancelTimer();
      state = state.copyWith(isShowingControlls: false);
    }
  }

  void setStartPressed() {
    state = state.copyWith(isStartPressed: true);
  }

  void setControllerState({
    required bool isPlaying,
    required bool isInitialized,
    required Duration position,
    required Duration duration,
  }) {
    state = state.copyWith(
      isPlaying: isPlaying,
      isInitialized: isInitialized,
      position: position,
      duration: duration,
    );
  }
}

@freezed
class VideoState with _$VideoState {
  const factory VideoState({
    required bool isStartPressed,
    required bool isInitialized,
    required bool isPlaying,
    required bool isShowingControlls,
    required Duration position,
    required Duration duration,
  }) = _VideoState;
}
