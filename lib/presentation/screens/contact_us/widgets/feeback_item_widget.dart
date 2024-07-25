import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class FeebackItemsWidget extends StatefulWidget {
  final String feebacktext;
  final Color? bordercolor;
  final bool isSelected;
  final Color? textColor;
  final Color? fillcolor;
  final VoidCallback onTap;
  const FeebackItemsWidget({
    super.key,
    required this.feebacktext,
    this.bordercolor,
    this.textColor,
    this.fillcolor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<FeebackItemsWidget> createState() => _FeebackItemsWidgetState();
}

class _FeebackItemsWidgetState extends State<FeebackItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.isSelected
                  ? AppColors.primaryColor
                  : widget.bordercolor ??
                      AppColors.neutral[300] ??
                      Colors.white12,
            ),
            borderRadius: BorderRadius.circular(20),
            color: widget.isSelected
                ? AppColors.primaryColor.withOpacity(0.2)
                : (widget.fillcolor ?? Colors.transparent)),
        child: Text(
          widget.feebacktext,
          style: TextStyle(
            fontSize: 10,
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}
