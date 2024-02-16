import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/theme/colors.dart';
import 'package:korkort_test/common/widgets/custom_shader_mask.dart';
import 'package:korkort_test/common/widgets/custom_sliver_persistent_header_delegate.dart';
import 'package:korkort_test/common/widgets/read_more_text.dart';

import '../controller/lesson_controller.dart';
import 'build_lessons_tab.dart';
import 'build_source_tab.dart';
import 'build_word_info_tab.dart';

class BuildScrollableContent extends ConsumerWidget {
  const BuildScrollableContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonState = ref.watch(lessonControllerProvider);

    if (lessonState.error != null && lessonState.lesson == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${lessonState.error}'),
          ],
        ),
      );
    }

    if (lessonState.lesson != null) {
      return const _Content();
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson =
        ref.watch(lessonControllerProvider.select((value) => value.lesson))!;

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 23,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                    ),
                    ReadMoreText(
                      '${lesson.text}  ',
                      trimMode: TrimMode.line,
                      trimLines: 5,
                      trimCollapsedText: 'läs_mer',
                      trimExpandedText: 'läs_less',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.8,
                      ),
                      moreStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      lessStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(height: 30, color: Colors.white),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverPersistentHeaderDelegate(
                minHeight: kToolbarHeight,
                maxHeight: kToolbarHeight,
                child: SizedBox(
                  width: double.infinity,
                  height: kToolbarHeight,
                  child: Material(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: TabBar(
                        isScrollable: false,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: kkColorPrimary,
                        unselectedLabelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.w600,
                          height: 24 / 14,
                        ),
                        labelColor: kkColorTitle,
                        unselectedLabelColor: kkColorBody,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.w600,
                          height: 24 / 14,
                        ),
                        tabs: const [
                          Tab(text: 'Lektioner'),
                          Tab(text: 'Ordlista'),
                          Tab(text: 'Resurs'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: const CustomShaderMask(
          child: TabBarView(
            children: [
              BuildLessonsTab(),
              BuildWordInfoTab(),
              BuildSourceTab(),
            ],
          ),
        ),
      ),
    );
  }
}
