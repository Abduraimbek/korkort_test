import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required int id,
    required String title,
    required String text,
    @JsonKey(name: 'lesson_time') required double lessonTime,
    required String image,
    required String video,
    required List<LessonThumb> lessons,
    @JsonKey(name: 'word_infos') required List<LessonWordInfo> wordInfos,
    required List<LessonSource> sources,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, Object?> json) => _$LessonFromJson(json);
}

@freezed
class LessonThumb with _$LessonThumb {
  const factory LessonThumb({
    required int id,
    @JsonKey(name: 'lesson_time') required double lessonTime,
    required String title,
    @JsonKey(name: 'is_open') required int isOpen,
  }) = _LessonThumb;

  factory LessonThumb.fromJson(Map<String, Object?> json) =>
      _$LessonThumbFromJson(json);
}

@freezed
class LessonWordInfo with _$LessonWordInfo {
  const factory LessonWordInfo({
    required String word,
    required String info,
  }) = _LessonWordInfo;

  factory LessonWordInfo.fromJson(Map<String, Object?> json) =>
      _$LessonWordInfoFromJson(json);
}

@freezed
class LessonSource with _$LessonSource {
  const factory LessonSource({
    required String text,
    required String link,
  }) = _LessonSource;

  factory LessonSource.fromJson(Map<String, Object?> json) =>
      _$LessonSourceFromJson(json);
}
