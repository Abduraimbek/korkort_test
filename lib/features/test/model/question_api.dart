import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_api.freezed.dart';
part 'question_api.g.dart';

@freezed
class QuestionAPI with _$QuestionAPI {
  const factory QuestionAPI({
    required int pk,
    @JsonKey(name: 'category_id') required int categoryId,
    String? image,
    @JsonKey(name: 'is_saved') required bool isSaved,
    required List<QuestionVariantAPI> variants,
    String? gif,
    @JsonKey(name: 'gif_last_frame_number') int? gifLastFrameNumber,
    @JsonKey(name: 'gif_duration') int? gifDuration,
    required String text,
  }) = _QuestionAPI;

  factory QuestionAPI.fromJson(Map<String, Object?> json) =>
      _$QuestionAPIFromJson(json);
}

@freezed
class QuestionVariantAPI with _$QuestionVariantAPI {
  const factory QuestionVariantAPI({
    required String text,
    @JsonKey(name: 'is_correct') required bool isCorrect,
  }) = _QuestionVariantAPI;

  factory QuestionVariantAPI.fromJson(Map<String, Object?> json) =>
      _$QuestionVariantAPIFromJson(json);
}
