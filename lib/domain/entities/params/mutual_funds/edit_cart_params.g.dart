// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_cart_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditCartParams _$EditCartParamsFromJson(Map<String, dynamic> json) =>
    EditCartParams(
      cartItemID: json['cartItemID'] as int,
      newAmount: json['newAmount'] as int,
    );

Map<String, dynamic> _$EditCartParamsToJson(EditCartParams instance) =>
    <String, dynamic>{
      'cartItemID': instance.cartItemID,
      'newAmount': instance.newAmount,
    };
