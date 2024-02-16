import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../test/controller/test_controller.dart';
import '../../test/repository/test_repository.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  bool isFetching = false;

  Future<void> fetchQuestions() async {
    setState(() {
      isFetching = true;
    });

    final (questions, error) =
        await ref.read(testRepositoryProvider).fetchQuestions();

    if (mounted) {
      setState(() {
        isFetching = false;
      });

      if (questions != null) {
        ref.read(testControllerProvider.notifier).initState(questions);
        Navigator.of(context).pushNamed('/test');
      } else if (error != null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(error),
              titleTextStyle: const TextStyle(color: Colors.red),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('For Testing'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _BuildButton(
                  onPressed: () => Navigator.of(context).pushNamed('/login'),
                  text: 'Login Page',
                ),
                _BuildButton(
                  onPressed: () => Navigator.of(context).pushNamed('/lesson'),
                  text: 'Lesson Page',
                ),
                _BuildButton(
                  onPressed: () => fetchQuestions(),
                  text: 'Test Page',
                ),
              ],
            ),
          ),
          if (isFetching)
            Positioned.fill(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}

class _BuildButton extends StatelessWidget {
  const _BuildButton({required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
