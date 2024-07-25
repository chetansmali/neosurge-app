import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class SimiliarQuestionTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const SimiliarQuestionTile(
      {super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.00, vertical: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary[50] ?? Colors.white,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0),
            horizontalTitleGap: 0,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.primaryColor,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
