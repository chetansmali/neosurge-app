import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../common/common.dart';
import '../../../data/models/user/user_notification.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/notifications/notification_action_cubit/notification_action_cubit.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_container.dart';
import '../profile/widgets/list_icon.dart';

class NotificationCard extends StatelessWidget {
  final UserNotification notification;
  final int index;
  const NotificationCard(
      {super.key, required this.notification, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        onTap: () {
          if (!notification.isRead) {
            context
                .read<NotificationActionCubit>()
                .markNotificationAsRead(index, notification);
          }
        },
        child: CustomContainer(
          radius: 16,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  1 == 1 //notification.icon == null
                      ? ListIcon(
                          iconData: Icons.notifications_rounded,
                          iconColor: AppColors.primaryColor,
                          iconSize: 30,
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.yellowPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Assets.pngs.goldBrick
                              .image(height: 20, width: 20)),
                  const Gap(16),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: baseTextStyle10600.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        notification.body,
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.mainBlack),
                      ),
                      const Gap(8),
                      Text(
                        getDateText(notification.createdAt.toLocal()),
                        style: baseTextStyle12400.copyWith(
                            color: AppColors.textGrey),
                      )
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDateText(DateTime date) {
    final today = DateTime.now();
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return DateFormat('hh:mm a').format(date);
    }
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day - 1) {
      return 'Yesterday';
    }
    return DateFormat('dd MMM yyyy').format(date);
  }
}
