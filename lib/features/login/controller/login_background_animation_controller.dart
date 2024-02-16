import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_background_animation_controller.g.dart';

@riverpod
class LoginBackgroundAnimationController
    extends _$LoginBackgroundAnimationController {
  @override
  int build() => 0;

  int _oldValue = 1;

  void changeState() {
    if (state == 0 && _oldValue == 1) {
      state = 1;
      _oldValue = 0;
      return;
    }

    if (state == 1 && _oldValue == 0) {
      state = 2;
      _oldValue = 1;
      return;
    }

    if (state == 2 && _oldValue == 1) {
      state = 1;
      _oldValue = 2;
      return;
    }

    if (state == 1 && _oldValue == 2) {
      state = 0;
      _oldValue = 1;
      return;
    }

    state = 1;
    _oldValue = 0;
    return;
  }
}
