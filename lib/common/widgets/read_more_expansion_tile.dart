import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReadMoreExpansionTile extends HookWidget {
  const ReadMoreExpansionTile({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: expanded.value ? null : 5,
        ),
        GestureDetector(
          onTap: () {
            expanded.value = !expanded.value;
          },
          child: Text(
            expanded.value ? 'Show less' : 'Show more',
            softWrap: false,
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
