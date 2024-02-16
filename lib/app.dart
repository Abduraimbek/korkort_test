import 'package:flutter/material.dart';

import 'common/theme/theme.dart';
import 'features/lesson/page/full_screen_lesson_page.dart';
import 'features/lesson/page/lesson_page.dart';
import 'features/login/page/login_page.dart';
import 'features/main/page/main_page.dart';
import 'features/test/page/test_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const MainPage(),
        '/login': (_) => const LoginPage(),
        '/lesson': (_) => const LessonPage(),
        '/fullScreenLesson': (_) => const FullScreenLessonPage(),
        '/test': (_) => const TestPage(),
      },
    );
  }
}
