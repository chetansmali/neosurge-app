import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/user/user_notification.dart';

abstract class NotificationRemoteDataSource {
  Future<List<UserNotification>> getUserNotifications(
      Map<String, dynamic> params);

  Future<void> markNotificationAsRead(Map<String, dynamic> params);

  Future<void> markAllNotificationsAsRead();

  Future<int> getUnreadNotificationCount();
}

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient _client;

  NotificationRemoteDataSourceImpl(this._client);

  @override
  Future<List<UserNotification>> getUserNotifications(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.getNotificationsEndPoint,
        queryParameters: params);
    return response
        .map<UserNotification>((json) => UserNotification.fromJson(json))
        .toList();
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    return await _client.post(ApiConstants.markAllNotificationsAsReadEndPoint);
  }

  @override
  Future<void> markNotificationAsRead(Map<String, dynamic> params) async {
    return await _client.post(ApiConstants.markNotificationAsReadEndPoint,
        params: params);
  }

  @override
  Future<int> getUnreadNotificationCount() async {
    final response =
        await _client.get(ApiConstants.getUnreadNotificationCountEndPoint);
    return response['notificationCount'];
  }
}
