import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../data/models/user/user_notification.dart';
import '../../../domain/entities/app_error.dart';
import '../../cubits/notifications/notification_action_cubit/notification_action_cubit.dart';
import '../../cubits/notifications/notification_count_cubit/notification_count_cubit.dart';
import '../../cubits/notifications/user_notification_cubit.dart';
import '../../widgets/empty_portfolio_view.dart';
import '../../widgets/widgets.dart';
import '../loading_screen.dart';
import 'notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final ScrollController _scrollController;
  bool _isLastPage = false;
  bool _isLoadError = false;
  AppErrorType _errorType = AppErrorType.api;
  String? _errorMessage;

  void _handleNotificationFetch() {
    context.read<UserNotificationCubit>().fetchUserNotifications();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _setupScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationActionCubit, NotificationActionState>(
      listener: (context, state) {
        if (state is NotificationActionSuccess) {
          if (state.isAllRead) {
            //Mark all as read inside the cubit itself
            context.read<UserNotificationCubit>().markAllNotificationsAsRead();
            //Set the notification unread count to 0
            context.read<NotificationCountCubit>().setToZero();
          } else {
            //Mark the notification as read inside the cubit itself
            context
                .read<UserNotificationCubit>()
                .markNotificationAsRead(state.index!);

            //Decrement the notification unread count by 1
            context.read<NotificationCountCubit>().subtractOne();
          }
        }
        if (state is NotificationActionError) {
          Utils.showErrorAlert(
            context,
            Utils.getErrorMessage(errorType: state.errorType, msg: state.error),
          );
        }
      },
      child: LoadingScreen(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notifications'),
            centerTitle: true,
            // actions: [
            //   // I feel it is better to use [NotificationCountCubit] to check if there are unread notifications,
            //   // instead of checking the length of the list of notifications as the latter is not reliable due
            //   // to pagination.
            //   // Given the scenario lets say 10 notifications are read and the 11th one is unread but not yet
            //   // fetched from the server, then the length of the list of notifications will be 10 and the
            //   // unread count will be 1, in this case the mark all as read button will come after the paginated data is loaded.
            //   BlocBuilder<UserNotificationCubit, UserNotificationState>(
            //     builder: (context, state) {
            //       if (state is UserNotificationLoaded && state.containsUnread) {
            //         return TextButton(
            //             onPressed: () {
            //               context
            //                   .read<NotificationActionCubit>()
            //                   .markAllNotificationsAsRead();
            //             },
            //             child: const Text('Mark all as read'));
            //       }
            //       return const SizedBox.shrink();
            //     },
            //   )
            // ],
          ),
          body: BlocBuilder<UserNotificationCubit, UserNotificationState>(
            builder: (context, state) {
              if (state is UserNotificationLoading && state.isFirstFetch) {
                return const Center(
                  child: CustomLoader(),
                );
              }

              if (state is UserNotificationLoaded && state.containsUnread) {
                context
                    .read<NotificationActionCubit>()
                    .markAllNotificationsAsRead();
              }

              if (state is UserNotificationLoadError && state.isFirstFetch) {
                return Center(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    error: state.error,
                    onRetry: () => context
                        .read<UserNotificationCubit>()
                        .fetchUserNotifications(),
                  ),
                );
              }
              List<UserNotification> notifications = [];
              bool isLoading = false;
              _isLoadError = false;
              if (state is UserNotificationLoadError) {
                _isLoadError = true;
                _errorType = state.errorType;
                _errorMessage = state.error;
                notifications = state.oldNotifications;
              } else if (state is UserNotificationLoading) {
                isLoading = true;
                notifications = state.oldNotifications;
              } else if (state is UserNotificationLoaded) {
                notifications = state.notifications;
                _isLastPage = state.isLastPage;
                isLoading = false;
              }
              if (notifications.isEmpty) {
                return const Center(
                  child: EmptyPortfolioView(
                    message: 'No Notifications yet!',
                  ),
                );
              }

              return ListView.builder(
                itemCount:
                    notifications.length + (isLoading || _isLoadError ? 1 : 0),
                controller: _scrollController,
                itemBuilder: (_, index) {
                  if (index < notifications.length) {
                    return NotificationCard(
                      notification: notifications[index],
                      index: index,
                    );
                  } else {
                    Timer(const Duration(milliseconds: 30), () {
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                    });
                    return _isLoadError
                        ? _errorWidget(_errorType, _errorMessage)
                        : _loadingIndicator();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CustomLoader(),
      ),
    );
  }

  Widget _errorWidget(AppErrorType appErrorType, String? errorMessage) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Utils.getErrorMessage(errorType: appErrorType, msg: errorMessage),
            textAlign: TextAlign.center,
          ),
          IconButton(
              onPressed: () => _handleNotificationFetch(),
              icon: const Icon(
                Icons.refresh,
              ))
        ],
      );

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          100) {
        if (_scrollController.position.pixels != 0 &&
            !_isLastPage &&
            !_isLoadError) {
          _handleNotificationFetch();
        }
      }
    });
  }
}
