import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../../common/utils.dart';

import '../../../../gen/assets.gen.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_proof_of_identity/upload_proof_of_identity_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/error_info_widget.dart';

class ComfirmPanScreen extends StatefulWidget {
  const ComfirmPanScreen({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<ComfirmPanScreen> createState() => _ComfirmPanScreenState();
}

class _ComfirmPanScreenState extends State<ComfirmPanScreen> {
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
              const Text(
                'PAN Upload',
                style: TextStyle(
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
                  fontSize: 16,
                ),
              ),
              const Gap(22),
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
              const SizedBox(
                height: 8,
              ),
              const Spacer(),
              ErrorInfoWidget(
                otpErrorMsg: errorMsg,
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: _uploadImage,
                child: BlocConsumer<UploadProofOfIdentityCubit,
                    UploadProofOfIdentityState>(
                  listener: (context, state) async {
                    if (state is UploadProofOfIdentitySuccess &&
                        !state.isFetch) {
                      context.read<OnboardingPageCubit>().goToNextPage();
                      Navigator.pop(context);
                      return;
                    }

                    if (state is UploadProofOfIdentityFailure &&
                        !state.isFetch) {
                      setState(() {
                        errorMsg = Utils.getErrorMessage(
                          errorType: state.errorType,
                          msg: state.errorMessage,
                        );
                      });
                      return;
                    }
                  },
                  builder: (context, state) {
                    if (state is UploadProofOfIdentityLoading) {
                      return Assets.animations.loading.lottie();
                    }

                    return const Text(
                      'Upload',
                    );
                  },
                ),
              ),
              const Gap(4),
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
                    child: const Text('Crop Image'),
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
                    child: const Text('Try Again'),
                  ),
                ],
              ),
              const Gap(8),
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
    if (context.read<UploadProofOfIdentityCubit>().state
        is UploadProofOfIdentityLoading) {
      return;
    }

    if (!(await Utils.isValidFileSize(File(capturedImage.path), 5))) {
      setState(() {
        errorMsg = 'File size should be less than 5 MB';
      });
      return;
    }

    if (mounted) {
      context.read<UploadProofOfIdentityCubit>().uploadProofOfIdentity(
            panImage: File(capturedImage.path),
          );
    }
  }

  void _tryAgain() {
    Navigator.pop(context);
  }
}
