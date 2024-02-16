import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

import '../model/question.dart';
import '../model/question_api.dart';

part 'test_repository.g.dart';

@riverpod
TestRepository testRepository(TestRepositoryRef ref) {
  return TestRepository(Dio());
}

class TestRepository {
  final Dio _dio;

  const TestRepository(this._dio);

  Future<(List<Question>?, String?)> fetchQuestions() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.lattmedkorkort.se/api/v1/lessons/191/questions/?language_id=1'),
        headers: {
          "Authorization": "Token 4fdf69192b9c2bfed3a741e3c7103e9742195c6e",
        },
      );
      final List parsed = jsonDecode(utf8.decode(response.bodyBytes));
      var questions = <Question>[];

      final folderPath =
          (await path_provider.getApplicationDocumentsDirectory()).path;

      for (final e in parsed) {
        final questionApi = QuestionAPI.fromJson(e);

        String? gif;
        String? gifPath;
        if (questionApi.gif != null) {
          gif = questionApi.gif;
          gifPath = path.join(folderPath, gif);
        }

        String? image;
        String? imagePath;
        if (questionApi.image?.contains('https://') == true) {
          image = questionApi.image;
          imagePath = path.join(folderPath, image);
        }

        final question = Question(
          pk: questionApi.pk,
          categoryId: questionApi.categoryId,
          isSaved: questionApi.isSaved,
          variants: questionApi.variants
              .map((e) => QuestionVariant(
                    text: e.text,
                    isCorrect: e.isCorrect,
                  ))
              .toList(),
          text: questionApi.text,
          answer: null,
          gif: questionApi.gif,
          gifDuration: questionApi.gifDuration,
          gifLastFrameNumber: questionApi.gifLastFrameNumber,
          image: image,
          gifPath: gifPath,
          imagePath: imagePath,
          gifBytes: null,
        );
        questions.add(question);
      }

      questions = await _downloadGifs(questions);

      return (questions, null);
    } catch (err) {
      return (null, err.toString());
    }
  }

  Future<List<Question>> _downloadGifs(List<Question> questions) async {
    final bytes = await Future.wait(
      [
        for (final e in questions)
          if (e.gif != null && e.gifPath != null) _downloadBytes(e.gif!),
      ],
      eagerError: true,
    );

    return [
      for (var i = 0; i < questions.length; i++)
        questions[i].copyWith(gifBytes: bytes[i]),
    ];
  }

  Future<void> _downloadImages(List<Question> questions) async {
    await Future.wait(
      [
        for (final e in questions)
          if (e.image != null && e.imagePath != null)
            _downloadFile(e.image!, e.imagePath!),
      ],
      eagerError: true,
    );
  }

  Future<Uint8List> _downloadBytes(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<void> _downloadFile(String url, String path) async {
    await _dio.download(url, path);
  }

  Future<void> deleteDownloadedGifsAndImages(List<Question> questions) async {
    await Future.wait([
      for (final e in questions)
        if (e.gifPath != null) _deleteFile(e.gifPath!),
      for (final e in questions)
        if (e.imagePath != null) _deleteFile(e.imagePath!),
    ]);
  }

  Future<void> _deleteFile(String path) async {
    await File(path).delete();
  }
}
