import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;

  const CustomLoader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      strokeCap: StrokeCap.round,
      valueColor:
          AlwaysStoppedAnimation<Color>(color ?? AppColors.primaryColor),
    );
  }
}
