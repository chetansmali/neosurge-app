// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_watchlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWatchlistModel _$CreateWatchlistModelFromJson(
        Map<String, dynamic> json) =>
    CreateWatchlistModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      associatedUserEmail: json['associatedUserEmail'] as String,
    );

Map<String, dynamic> _$CreateWatchlistModelToJson(
        CreateWatchlistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'associatedUserEmail': instance.associatedUserEmail,
    };
