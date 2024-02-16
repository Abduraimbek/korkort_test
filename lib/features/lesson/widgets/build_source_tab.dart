import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/theme/colors.dart';

import '../controller/lesson_controller.dart';

class BuildSourceTab extends ConsumerWidget {
  const BuildSourceTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson =
        ref.watch(lessonControllerProvider.select((value) => value.lesson))!;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: lesson.sources.length,
      itemBuilder: (context, index) {
        final item = lesson.sources[index];

        return Padding(
          padding: const EdgeInsets.only(left: 22, right: 22, bottom: 5),
          child: Container(
            height: 42,
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
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.text,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontSize: 12,
                              height: 16.39 / 12,
                              color: kkColorTitle,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/svg/go_to.svg',
                            height: 16,
                            width: 16,
                          ),
                        ],
                      ),
                    ),
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
