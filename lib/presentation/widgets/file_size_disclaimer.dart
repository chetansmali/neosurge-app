import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FileSizeDisclaimer extends StatelessWidget {
  final bool isVideo;
  final bool isAadhaar;

  const FileSizeDisclaimer({Key? key, this.isVideo = false, this.isAadhaar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info,
          size: 14,
          color: Colors.grey,
        ),
        const Gap(5),
        Expanded(
          child: Text(
            isVideo ? 'Video should be in MP4 format and less than 10 MB' : 'Image should be in JPG or PNG format and should be less than ${isAadhaar ? 2 : 5}MB',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
