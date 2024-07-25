import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common/common.dart';
import '../../../../flavors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/account/update_profile_photo_cubit/update_profile_photo_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../widgets/widgets.dart';
import 'profile_photo_bottom_sheet.dart';

class ProfileImage extends StatelessWidget {
  //Default size is 40
  final double size;
  final bool isEdit;

  const ProfileImage({Key? key, this.size = 40, this.isEdit = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
        context.select((AuthCubit bloc) => bloc.state.user!.profileImage);

    return Stack(
      children: [
        imageUrl == null
            ? Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Icon(Icons.person, size: size / 2, color: Colors.white),
              )
            : CachedNetworkImage(
                imageUrl: '${F.baseUrl}/$imageUrl',
                width: size,
                placeholder: (context, url) {
                  return CustomShimmer(
                    child: Container(
                      width: size,
                      height: size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                fit: BoxFit.cover,
                height: size,
              ),
        if (isEdit) ...[
          BlocConsumer<UpdateProfilePhotoCubit, UpdateProfilePhotoState>(
            listener: (context, state) {
              if (state is UpdateProfilePhotoSuccess) {
                Fluttertoast.showToast(
                  msg: 'Profile photo updated successfully',
                );
                context.read<AuthCubit>().updateUser(state.user);
              }
              if (state is UpdateProfilePhotoFailure) {
                Fluttertoast.showToast(
                    msg: Utils.getErrorMessage(
                        errorType: state.errorType, msg: state.message));
              }
            },
            builder: (context, state) {
              if (state is UpdateProfilePhotoLoading) {
                return Positioned(
                  bottom: size / 3,
                  right: size / 3,
                  child: const CustomLoader(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Positioned(
            bottom: -6,
            right: -6,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: context.read<UpdateProfilePhotoCubit>(),
                    child: const ProfilePhotoBottomSheet(),
                  ),
                );
              },
              icon: Assets.icons.profileImageCamera
                  .image(height: 30.0, width: 30.0),
              color: Colors.white,
            ),
          )
        ],
      ],
    );
  }
}
