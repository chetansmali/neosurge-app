import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class ListIcon extends StatelessWidget {
  final SvgGenImage? svgImage;
  final Color? backgroundColor;
  final double? size;
  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;

  const ListIcon(
      {Key? key,
      this.svgImage,
      this.size,
      this.backgroundColor,
      this.iconData,
      this.iconColor,
      this.iconSize})
      : assert(svgImage != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 44,
      height: size ?? 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.primaryLightColor,
      ),
      child: Center(
        child: svgImage == null
            ? Icon(
                iconData!,
                color: iconColor ?? AppColors.primaryColor,
                size: iconSize ?? 20,
              )
            : svgImage!.svg(
                colorFilter: ColorFilter.mode(
                  iconColor ?? AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}
