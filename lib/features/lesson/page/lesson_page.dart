import 'package:flutter/material.dart';
import 'package:korkort_test/common/widgets/custom_app_bar_button.dart';

import '../widgets/build_scrollable_content.dart';
import '../widgets/build_video_content.dart';
import '../widgets/build_video_loader.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomAppBarButton(
          onPressed: () {},
          icon: Icons.close,
        ),
        centerTitle: true,
        title: const Text('Träningsprov'),
        actions: [
          CustomAppBarButton(
            onPressed: () {},
            icon: Icons.error_outline,
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: const Column(
        children: [
          BuildVideoContent(
            height: 255,
            loader: BuildVideoLoader(height: 255),
          ),
          Expanded(
            child: BuildScrollableContent(),
          ),
        ],
      ),
    );
  }
}
