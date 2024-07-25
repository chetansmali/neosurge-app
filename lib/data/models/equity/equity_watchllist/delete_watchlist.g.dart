// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_watchlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteWatchlistModel _$DeleteWatchlistModelFromJson(
        Map<String, dynamic> json) =>
    DeleteWatchlistModel(
      success: json['success'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeleteWatchlistModelToJson(
        DeleteWatchlistModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
