import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../theme/app_colors.dart';

class ImageItems extends StatefulWidget {
  final Widget imageUrl;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const ImageItems(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.isSelected,
      required this.onTap});

  @override
  State<ImageItems> createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItems> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
              color: widget.isSelected ? Colors.blue[50] : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 35, height: 35, child: widget.imageUrl
                      // SvgPicture.network( widget.imageUrl
                      ),
                  const Gap(
                      5), //  colorBlendMode: widget.isSelected ? BlendMode.color : null,
                  Expanded(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                    ),
                  ),
                ],
              ),
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
