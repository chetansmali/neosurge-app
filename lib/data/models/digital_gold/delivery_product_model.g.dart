// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryProductModel _$DeliveryProductModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryProductModel(
      sku: json['sku'] as String,
      name: json['name'] as String,
      productWeight: (json['productWeight'] as num).toDouble(),
      reedemWeight: (json['reedemWeight'] as num).toDouble(),
      metalType: $enumDecode(_$MetalTypeEnumMap, json['metalType']),
      purity: (json['purity'] as num).toDouble(),
      jewelleryType: json['jewelleryType'] as String,
      productSize: json['productSize'] as String?,
      basePrice: (json['basePrice'] as num).toDouble(),
      description: json['description'] as String?,
      status: json['status'] as String,
      productImages: (json['productImages'] as List<dynamic>)
          .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultImageUrl: json['defaultImageUrl'] as String?,
    );

Map<String, dynamic> _$DeliveryProductModelToJson(
        DeliveryProductModel instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'name': instance.name,
      'productWeight': instance.productWeight,
      'reedemWeight': instance.reedemWeight,
      'metalType': _$MetalTypeEnumMap[instance.metalType]!,
      'purity': instance.purity,
      'jewelleryType': instance.jewelleryType,
      'productSize': instance.productSize,
      'basePrice': instance.basePrice,
      'description': instance.description,
      'status': instance.status,
      'productImages': instance.productImages,
      'defaultImageUrl': instance.defaultImageUrl,
    };

const _$MetalTypeEnumMap = {
  MetalType.gold: 'gold',
  MetalType.silver: 'silver',
};

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
      id: json['id'] as int,
      url: json['url'] as String,
      displayOrder: json['displayOrder'] as int,
      defaultImage: json['defaultImage'] as bool,
    );

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'displayOrder': instance.displayOrder,
      'defaultImage': instance.defaultImage,
    };
