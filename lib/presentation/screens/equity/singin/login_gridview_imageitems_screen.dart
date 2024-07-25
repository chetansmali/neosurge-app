import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../theme/app_colors.dart';

class ImageItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const ImageItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ImageItem> createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: 200,
            // height: 200,
            decoration: BoxDecoration(
              border: widget.isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : Border.all(color: Colors.blue.shade100, width: 2),
              borderRadius: BorderRadius.circular(10),
              color: widget.isSelected ? Colors.blue[50] : null,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 38,
                  height: 38,
                  child: CachedNetworkImage(imageUrl: widget.imageUrl),
                ),
                const Gap(5),
                //  colorBlendMode: widget.isSelected ? BlendMode.color : null,
                Text(
                  widget.name,
                  style: baseTextStyle10400.copyWith(
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          if (widget.isSelected)
            const Positioned(
              right: 5,
              top: 8,
              child: Icon(
                Icons.check_circle_outline_sharp,
                size: 18,
                color: AppColors.primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
