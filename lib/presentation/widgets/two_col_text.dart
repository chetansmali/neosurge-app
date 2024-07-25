import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TwoColText extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const TwoColText({Key? key, required this.title, required this.subtitle, this.subtitleStyle, this.titleStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: titleStyle ?? const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
        ),
        const Gap(10),
        Text(
          subtitle,
          style: subtitleStyle ??
              const TextStyle(
                fontSize: 11,
              ),
        ),
      ],
    );
  }
}
