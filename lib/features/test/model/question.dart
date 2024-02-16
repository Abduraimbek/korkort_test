import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';

// class Question {
//   final int pk;
//   final int categoryId;
//   final String ? image;
//   final bool isSaved;
// }

@freezed
class Question with _$Question {
  const factory Question({
    required int pk,
    required int categoryId,
    String? image,
    required bool isSaved,
    required List<QuestionVariant> variants,
    String? gif,
    int? gifLastFrameNumber,
    int? gifDuration,
    required String text,
    int? answer,
    required String? imagePath,
    required String? gifPath,
    required Uint8List? gifBytes,
  }) = _Question;
}

@freezed
class QuestionVariant with _$QuestionVariant {
  const factory QuestionVariant({
    required String text,
    required bool isCorrect,
  }) = _QuestionVariant;
}
