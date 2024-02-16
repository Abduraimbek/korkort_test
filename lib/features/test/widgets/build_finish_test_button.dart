import 'package:flutter/material.dart';
import 'package:korkort_test/common/widgets/custom_app_bar_button.dart';

class BuildFinishTestButton extends StatelessWidget {
  const BuildFinishTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBarButton(
      onPressed: () async {
        final res = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Finish test?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        if (context.mounted && res == true) {
          Navigator.of(context).pop();
        }
      },
      icon: Icons.close,
    );
  }
}
