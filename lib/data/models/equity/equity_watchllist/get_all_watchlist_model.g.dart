// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_watchlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllWatchlistModel _$GetAllWatchlistModelFromJson(
        Map<String, dynamic> json) =>
    GetAllWatchlistModel(
      id: json['id'] as int,
      name: json['name'] as String,
      associatedUserEmail: json['associatedUserEmail'] as String,
    );

Map<String, dynamic> _$GetAllWatchlistModelToJson(
        GetAllWatchlistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'associatedUserEmail': instance.associatedUserEmail,
    };
