import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';

class ConfirmPOAResult {
  ConfirmPOAResult({
    required this.documentType,
    this.imagePath,
  });

  final String documentType;
  String? imagePath;
}

class ComfirmPOAScreen extends StatefulWidget {
  const ComfirmPOAScreen({
    super.key,
    required this.imagePath,
    required this.documentType,
  });

  final String documentType;
  final String imagePath;

  @override
  State<ComfirmPOAScreen> createState() => _ComfirmPOAScreenState();
}

class _ComfirmPOAScreenState extends State<ComfirmPOAScreen> {
  late XFile capturedImage;
  String? errorMsg;

  @override
  void initState() {
    capturedImage = XFile(widget.imagePath);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                '${widget.documentType} Upload',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Gap(8),
              const Text(
                'Please make sure that the image is clearly visible and is placed within the box.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const Gap(64),
              Center(
                child: ClipRRect(
                  child: SizedOverflowBox(
                    size: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: Image.file(
                      File(capturedImage.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: _cropImage,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Row(
                      children: [
                        Assets.icons.crop.svg(),
                        const Gap(8),
                        const Text('Crop Image'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _tryAgain,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Row(
                      children: [
                        Assets.icons.refresh.svg(),
                        const Gap(8),
                        const Text('Try Again'),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ErrorInfoWidget(
                otpErrorMsg: errorMsg,
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text(
                  'Upload',
                ),
              ),
              const Gap(4),
            ],
          ),
        ),
      ),
    );
  }

  void _cropImage() async {
    var croppedFile = await ImageCropper().cropImage(
      sourcePath: capturedImage.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );

    if (croppedFile == null) {
      return;
    }

    capturedImage = XFile(croppedFile.path);

    setState(() {});
  }

  void _uploadImage() async {
    if (mounted) {
      Navigator.pop(
        context,
        ConfirmPOAResult(
          documentType: widget.documentType,
          imagePath: capturedImage.path,
        ),
      );
    }
  }

  void _tryAgain() {
    Navigator.pop(
      context,
      ConfirmPOAResult(
        documentType: widget.documentType,
      ),
    );
  }
}
