import 'dart:convert';

import 'package:async/async.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/lesson.dart';

part 'lesson_controller.freezed.dart';
part 'lesson_controller.g.dart';

@riverpod
class LessonController extends _$LessonController {
  CancelableOperation<(Lesson?, String?)>? _cancelableOperation;

  void _cancelPreviousOperation() {
    _cancelableOperation?.cancel();
    _cancelableOperation = null;
  }

  Future<void> fetchLesson({
    required int id,
    required bool setFetchingState,
  }) async {
    _cancelPreviousOperation();

    Future<(Lesson?, String?)> future() async {
      try {
        final response = await http.get(
          Uri.parse(
              'https://api.lattmedkorkort.se/api/v1/lessons/$id/?language_id=1'),
          headers: {
            "Authorization": "Token 4fdf69192b9c2bfed3a741e3c7103e9742195c6e",
          },
        );
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return (Lesson.fromJson(json), null);
      } catch (err) {
        return (null, err.toString());
      }
    }

    if (setFetchingState) {
      state = state.copyWith(isFetching: true);
    }

    _cancelableOperation = CancelableOperation.fromFuture(
      future(),
      onCancel: () => null,
    );

    final result = await _cancelableOperation?.valueOrCancellation();

    if (result != null) {
      state = state.copyWith(
        isFetching: false,
        lesson: result.$1,
        error: result.$2,
      );
    }
  }

  @override
  LessonState build() {
    ref.onDispose(() {
      _cancelPreviousOperation();
    });

    fetchLesson(id: 191, setFetchingState: false);

    return const LessonState(
      isFetching: true,
      lesson: null,
      error: null,
    );
  }
}

@freezed
class LessonState with _$LessonState {
  const factory LessonState({
    required bool isFetching,
    required Lesson? lesson,
    required String? error,
  }) = _LessonState;
}
