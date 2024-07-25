import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class ProfileListTiles extends StatelessWidget {
  const ProfileListTiles({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.routeName,
    this.isProfileTile = false,
    this.isLogOutButton = false,
  });
  final String title, subTitle, routeName;
  final Widget icon;
  final bool isProfileTile, isLogOutButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () async {
        if (isLogOutButton) {
          await _logOutLogic(context);
        } else {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Row(
          children: [
            icon,
            const Gap(20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: isProfileTile
                        ? baseTextStyle14500.copyWith(
                            color: AppColors.neutral[800])
                        : baseTextStyle14400.copyWith(
                            color: AppColors.neutral[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4.0),
                  Text(
                    subTitle,
                    style: baseTextStyle10400.copyWith(
                        color: isProfileTile
                            ? AppColors.primary[500]
                            : AppColors.neutral[200]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Gap(20.0),
            Assets.icons.profileTileArrow.image(height: 20.0, width: 20.0),
          ],
        ),
      ),
    );
  }

  Future<void> _logOutLogic(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(
          'Logout?',
          style: baseTextStyle16500,
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: baseTextStyle14400,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'Cancel',
              style: baseTextStyle16400,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text(
              'Logout',
              style: baseTextStyle16500.copyWith(color: AppColors.errorRed),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, routeName, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
