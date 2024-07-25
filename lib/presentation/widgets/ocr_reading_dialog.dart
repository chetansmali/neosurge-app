import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'custom_loader.dart';

class OcrReadingDialog extends StatelessWidget {
  const OcrReadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomLoader(),
              Gap(10),
              Text('Reading OCR text...'),
            ],
          ),
        ),
      ),
    );
  }
}
