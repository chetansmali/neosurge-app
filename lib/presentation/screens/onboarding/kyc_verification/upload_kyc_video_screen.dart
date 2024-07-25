import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../constants/kyc_steps_constants.dart';
import '../../../../core/location_service.dart';
import '../../../cubits/onboarding/get_kyc_video_otp/get_kyc_video_otp_cubit.dart';
import '../../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../../cubits/onboarding/upload_kyc_video/upload_kyc_video_cubit.dart';
import '../../../cubits/util_cubits/loading_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/error_info_widget.dart';

class UploadKycVideoScreen extends StatefulWidget {
  ///Creates a screen that allows the user to upload a video to be verified.
  const UploadKycVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadKycVideoScreen> createState() => _UploadKycVideoScreenState();
}

class _UploadKycVideoScreenState extends State<UploadKycVideoScreen> {
  VideoPlayerController? _controller;
  File? _videoFile;
  Future<void>? initializeVideoPlayerFuture;
  late final ImagePicker _imagePicker;
  late final Position _position;
  bool _locationSuccess = false;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  void didChangeDependencies() {
    _fetchExistingDataOrOtp();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _fetchExistingDataOrOtp() async {
    _locationSuccess = await _fetchLocation();
    setState(() {});
    if (!mounted) return;
    final int maxCompletedStep =
        context.read<OnboardingPageCubit>().state.maxCompletedStep;
    final bool isKycCompliant =
        context.read<OnboardingPageCubit>().state.isKycCompliant;
    if (maxCompletedStep >= NonKycFlowRoutes.userVideoUploded.value &&
        !isKycCompliant) {
      context.read<UploadKycVideoCubit>().fetchVideo();
    } else {
      if (_locationSuccess) {
        context
            .read<GetKycVideoOtpCubit>()
            .getKycVideoOtp(lat: _position.latitude, long: _position.longitude);
      }
    }
  }

  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return !_locationSuccess
        ? const Scaffold()
        : Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                  child: ElevatedButton(
                      onPressed:
                          _videoFile == null ? _captureVideo : _uploadVideo,
                      child:
                          Text(_videoFile == null ? 'Open Camera' : 'Next'))),
            ),
            body: BlocConsumer<UploadKycVideoCubit, UploadKycVideoState>(
              listener: (context, state) {
                if (state is UploadKycVideoSuccess && !state.isFetch) {
                  context.read<OnboardingPageCubit>().goToNextPage();
                  return;
                }
                if (state is UploadKycVideoSuccess && state.isFetch) {
                  _videoFile = state.kycVideoFile!;
                  _controller = VideoPlayerController.file(_videoFile!);
                  initializeVideoPlayerFuture = _controller!.initialize();
                }
                if (state is UploadKycVideoFailure && !state.isFetch) {
                  setState(() {
                    errorMsg = state.errorMessage;
                  });
                  // Utils.showErrorAlert(
                  //     context,
                  //     Utils.getErrorMessage(errorType: state.errorType, msg: state.errorMessage),
                  //   );
                }
              },
              builder: (context, state) {
                if (state is UploadKycVideoLoading && state.isFetch) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (state is UploadKycVideoFailure && state.isFetch) {
                  return Center(
                    child: Text(Utils.getErrorMessage(
                        errorType: state.errorType, msg: state.errorMessage)),
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Video Verification',
                              style: baseTextStyle2,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(5),
                            Text(
                              'Please upload a video you facing the camera and saying the below mentioned code audibly.',
                              textAlign: TextAlign.start,
                              style: baseTextStyle1,
                            ),
                            // const Gap(30),
                            // const FileSizeDisclaimer(
                            //   isVideo: true,
                            // ),
                            const Gap(5),
                            _videoFile != null
                                ? Container(
                                    decoration:
                                        CustomStyles.kycUploadDecoration,
                                    width: double.maxFinite,
                                    height: 300,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: FutureBuilder(
                                            future: initializeVideoPlayerFuture,
                                            builder: (context, snapshot) =>
                                                snapshot.connectionState ==
                                                        ConnectionState.done
                                                    ? AspectRatio(
                                                        aspectRatio:
                                                            _controller!.value
                                                                .aspectRatio,
                                                        child: VideoPlayer(
                                                            _controller!),
                                                      )
                                                    : const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: AppColors.textRed,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                context
                                                    .read<GetKycVideoOtpCubit>()
                                                    .getKycVideoOtp(
                                                        lat: _position.latitude,
                                                        long: _position
                                                            .longitude);
                                                _videoFile = null;
                                                _controller?.dispose();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            _videoFile != null
                                ? ValueListenableBuilder(
                                    valueListenable: _controller!,
                                    builder: (context, VideoPlayerValue value,
                                        child) {
                                      return IconButton(
                                        onPressed: () {
                                          if (value.isPlaying) {
                                            _controller!.pause();
                                          } else {
                                            _controller!.play();
                                          }
                                        },
                                        iconSize: 50,
                                        icon: value.isPlaying
                                            ? const Icon(
                                                Icons.pause,
                                                color: AppColors.primaryColor,
                                              )
                                            : const Icon(
                                                Icons.play_arrow,
                                                color: AppColors.primaryColor,
                                              ),
                                      );
                                    })
                                : const SizedBox.shrink(),
                            BlocBuilder<GetKycVideoOtpCubit,
                                GetKycVideoOtpState>(
                              builder: (context, state) {
                                if (state is GetKycVideoOtpLoaded) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(8),
                                      elevation: 1,
                                      child: Container(
                                        height: screenHeight / 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Your Code : ',
                                                style: baseTextStyle,
                                              ),
                                              Text(state.otp,
                                                  style: baseTextStyle3),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is GetKycVideoOtpLoading) {
                                  return const Center(
                                      child: Text('Loading OTP...'));
                                }
                                if (state is GetKycVideoOtpFailure) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Failed to load OTP'),
                                      const Gap(5),
                                      GestureDetector(
                                        onTap: () => context
                                            .read<GetKycVideoOtpCubit>()
                                            .getKycVideoOtp(
                                                lat: 34.65, long: -86.85),
                                        child: const Text(
                                          'Retry',
                                          style: TextStyle(
                                              color: AppColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            const Spacer(),
                            const Gap(20),
                            // const Center(
                            //   child: DataSecure(),
                            // ),
                            // const Gap(5),
                            if (errorMsg != null && errorMsg!.isNotEmpty)
                              ErrorInfoWidget(otpErrorMsg: errorMsg),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
  }

  void _captureVideo() async {
    context.read<LoadingCubit>().show();
    final XFile? file = await _imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 5),
        preferredCameraDevice: CameraDevice.front);

    if (file != null) {
      try {
        MediaInfo? mediaInfo = await VideoCompress.compressVideo(
          file.path,
          quality: VideoQuality.LowQuality,
          deleteOrigin: true,

          // It's false by default
        );
        // File videoFile = File(file.path);

        //Note: mediaInfo can be null if the video is failed to compress so we can try using the original file
        //this could occur in case of some low end devices.

        if (await Utils.isValidFileSize(
            mediaInfo?.file ?? File(file.path), 10)) {
          _videoFile = mediaInfo?.file ?? File(file.path);
          _controller = VideoPlayerController.file(_videoFile!);
          initializeVideoPlayerFuture = _controller!.initialize();
          setState(() {});
        } else {
          Fluttertoast.showToast(msg: 'Video size should be less than 10MB');
        }
      } catch (e) {
        FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      }
    }
    if (!mounted) return;
    context.read<LoadingCubit>().hide();
  }

  void _uploadVideo() {
    context.read<UploadKycVideoCubit>().uploadVideo(videoFile: _videoFile!);
  }

  Future<bool> _fetchLocation() async {
    try {
      context.read<LoadingCubit>().show();
      _position = await LocationService.determinePosition();
      return true;
    } catch (e) {
      final Location location = Location();
      if (e == LocationError.locationDenied) {
        Fluttertoast.showToast(
            msg: "Location permission is required to proceed");
      } else if (e == LocationError.locationDisabled) {
        Fluttertoast.showToast(msg: "Please enable location service");
        bool result = await location.requestService();
        if (!result) {
          Fluttertoast.showToast(
              msg: "Location must be enabled to proceed ahead");
        } else {
          Fluttertoast.showToast(msg: "Location Service enabled successfully");
          _position = await LocationService.determinePosition();
          return true;
        }
      } else if (e == LocationError.locationDeniedPermanently) {
        Fluttertoast.showToast(
            msg: "Location permission is required to proceed");
      }
      return false;
    } finally {
      if (context.mounted) {
        context.read<LoadingCubit>().hide();
      }
    }
  }
}
