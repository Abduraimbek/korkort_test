import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';

class BuildQuestionImage extends StatelessWidget {
  const BuildQuestionImage({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height / 4.6;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: question.image!,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
