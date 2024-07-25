import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_colors.dart';

class StepperIcon extends StatelessWidget {
  final SvgPicture icon;
  final bool isCompleted;
  final String text;

  const StepperIcon({Key? key, required this.icon, this.isCompleted = false, required this.text})
      // : assert(isCompleted && icon != null),

      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.green : AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: isCompleted
                  ? Stack(
                      children: [
                        Opacity(
                          opacity: 0.4,
                          child: icon,
                        ),
                        const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        icon,
                      ],
                    ),
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: isCompleted ? AppColors.green : AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
