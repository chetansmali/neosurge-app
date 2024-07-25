import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {super.key, required this.onChanged, required this.value});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<CustomCheckBox> createState() => CustomCheckBoxState();
}

class CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.value ? AppColors.primary[50] : null,
          border: Border.all(
            width: 1.5,
            color: widget.value
                ? AppColors.primary[500]!
                : AppColors.neutral[300]!,
          ),
        ),
        child: widget.value
            ? Center(
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: AppColors.primary[500],
                ),
              )
            : null,
      ),
    );
  }
}
