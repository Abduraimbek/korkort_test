import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/theme/colors.dart';

import '../controller/lesson_controller.dart';

class BuildWordInfoTab extends ConsumerWidget {
  const BuildWordInfoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson =
        ref.watch(lessonControllerProvider.select((value) => value.lesson))!;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 60),
      itemCount: lesson.wordInfos.length,
      itemBuilder: (context, index) {
        final item = lesson.wordInfos[index];

        return Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, bottom: 5),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 32,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.04),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Material(
                color: Colors.white,
                child: ListTileTheme(
                  data: const ListTileThemeData(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: 15,
                      top: 2,
                      bottom: 2,
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      item.word,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 16.39 / 12,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                        color: kkColorTitle,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none,
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    childrenPadding: const EdgeInsets.only(
                      left: 20,
                      right: 15,
                      bottom: 10,
                    ),
                    children: [
                      Text(
                        item.info,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 16.39 / 12,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          color: kkColorTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
