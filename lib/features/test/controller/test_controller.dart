import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/question.dart';

part 'test_controller.freezed.dart';
part 'test_controller.g.dart';

// @riverpod
// FutureOr<List<Question>> questionsFetch(QuestionsFetchRef ref) async {
//   final client = await ref.getDebouncedHttpClient();

//   final response = await client.get(
//     Uri.parse(
//         'https://api.lattmedkorkort.se/api/v1/lessons/191/questions/?language_id=1'),
//     headers: {
//       "Authorization": "Token 4fdf69192b9c2bfed3a741e3c7103e9742195c6e",
//     },
//   );
//   final List json = jsonDecode(utf8.decode(response.bodyBytes));

//   return json.map((e) => Question.fromJson(e)).toList();
// }

@Riverpod(keepAlive: true)
class TestController extends _$TestController {
  void initState(List<Question> questions) {
    state = TestState(questions: questions, currentIndex: 0);
  }

  @override
  TestState build() {
    return const TestState(questions: [], currentIndex: 0);
  }

  void answer(int variantIndex) {
    state = state.copyWith(
      questions: [
        for (var i = 0; i < state.questions.length; i++)
          if (state.currentIndex == i)
            state.questions[i].copyWith(answer: variantIndex)
          else
            state.questions[i],
      ],
    );
  }

  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }
}

@freezed
class TestState with _$TestState {
  const factory TestState({
    required List<Question> questions,
    required int currentIndex,
  }) = _TestState;
}
