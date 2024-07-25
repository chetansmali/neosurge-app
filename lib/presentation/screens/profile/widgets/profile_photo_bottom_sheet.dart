import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/common.dart';
import '../../../cubits/account/update_profile_photo_cubit/update_profile_photo_cubit.dart';
import '../../../theme/app_colors.dart';

class ProfilePhotoBottomSheet extends HookWidget {
  const ProfilePhotoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagePicker = useMemoized(() => ImagePicker());
    return SizedBox(
      height: 170,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Profile Photo',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final profilePhotoCubit =
                            context.read<UpdateProfilePhotoCubit>();
                        Navigator.pop(context);

                        imagePicker
                            .pickImage(
                                source: ImageSource.gallery, imageQuality: 60)
                            .onError((error, stackTrace) {
                          Utils.showErrorAlert(context, 'Permission denied');
                          return null;
                        }).then((file) async {
                          if (file != null) {
                            if (!await Utils.isValidFileSize(
                                File(file.path), 2)) {
                              Fluttertoast.showToast(
                                msg: 'File size is must be less than 2 MB',
                              );
                              return;
                            }
                            profilePhotoCubit.updateProfilePhoto(
                                file: File(file.path));
                          }
                        });
                      },
                      icon: Icon(
                        Icons.photo_library,
                        color: AppColors.neutral[400],
                        size: 30.0,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'Gallery',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Gap(30.0),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final profilePhotoCubit =
                            context.read<UpdateProfilePhotoCubit>();
                        Navigator.pop(context);

                        await imagePicker
                            .pickImage(
                                source: ImageSource.camera, imageQuality: 100)
                            .onError((error, stackTrace) {
                          Utils.showErrorAlert(context, 'Permission denied');
                          return null;
                        }).then((file) async {
                          if (file != null) {
                            if (!await Utils.isValidFileSize(
                                File(file.path), 2)) {
                              Fluttertoast.showToast(
                                msg: 'File size is must be less than 2 MB',
                              );
                              return;
                            }
                            profilePhotoCubit.updateProfilePhoto(
                                file: File(file.path));
                          }
                        });
                      },
                      icon: Icon(
                        Icons.photo_camera,
                        color: AppColors.neutral[400],
                        size: 30.0,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'Camera',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
