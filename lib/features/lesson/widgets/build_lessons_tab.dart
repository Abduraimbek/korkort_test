import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/extensions/double_extensions.dart';
import 'package:korkort_test/common/extensions/int_extensions.dart';
import 'package:korkort_test/common/theme/colors.dart';

import '../controller/lesson_controller.dart';
import '../model/lesson.dart';

class BuildLessonsTab extends ConsumerWidget {
  const BuildLessonsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesson =
        ref.watch(lessonControllerProvider.select((value) => value.lesson))!;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 40),
      itemCount: lesson.lessons.length,
      itemBuilder: (context, index) {
        final item = lesson.lessons[index];
        final isCurrent = lesson.id == item.id;

        if (isCurrent) {
          return _BuildCurrentItem(lessonThumb: item, index: index);
        } else {
          return _BuildItem(lessonThumb: item, index: index);
        }
      },
    );
  }
}

class _BuildCurrentItem extends ConsumerWidget {
  const _BuildCurrentItem({
    required this.lessonThumb,
    required this.index,
  });

  final LessonThumb lessonThumb;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 11, left: 24, right: 24),
      child: Card(
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        color: kkColorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Text(
            (index + 1).addPadLeftZero,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 29.05 / 24,
              color: Colors.white,
            ),
          ),
          title: Text(
            lessonThumb.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 19.36 / 16,
            ),
          ),
          subtitle: Text(
            '${lessonThumb.lessonTime.addPadLeftZero} Minutes',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 16.94 / 14,
            ),
          ),
          trailing: Card(
            margin: EdgeInsets.zero,
            surfaceTintColor: Colors.transparent,
            shape: const CircleBorder(),
            color: Colors.white,
            child: Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/svg/pause.svg',
                height: 15,
                width: 15,
                colorFilter: const ColorFilter.mode(
                  kkColorIconOnWhite,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildItem extends ConsumerWidget {
  const _BuildItem({
    required this.lessonThumb,
    required this.index,
  });

  final LessonThumb lessonThumb;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7, left: 43, right: 24),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: () {
            ref
                .read(lessonControllerProvider.notifier)
                .fetchLesson(id: 191, setFetchingState: true);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Text(
            (index + 1).addPadLeftZero,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 21.78 / 18,
              color: kkColorBody,
            ),
          ),
          title: Text(
            lessonThumb.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: kkColorIconOnWhite,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 16.94 / 14,
            ),
          ),
          subtitle: Text(
            '${lessonThumb.lessonTime.addPadLeftZero} Minutes',
            style: const TextStyle(
              color: kkColorBody,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 14.52 / 12,
            ),
          ),
          trailing: Card(
            margin: EdgeInsets.zero,
            shape: const CircleBorder(),
            surfaceTintColor: Colors.transparent,
            color: Colors.white,
            child: Container(
              width: 45,
              height: 45,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                lessonThumb.isOpen == 4
                    ? 'assets/svg/crown.svg'
                    : 'assets/svg/lock.svg',
                height: 18,
                width: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
