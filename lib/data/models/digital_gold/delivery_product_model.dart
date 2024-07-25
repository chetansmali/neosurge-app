import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';

part 'delivery_product_model.g.dart';

@JsonSerializable()
class DeliveryProductModel {
  final String sku;
  final String name;
  final double productWeight;
  final double reedemWeight;
  final MetalType metalType;
  final double purity;
  final String jewelleryType;
  final String? productSize;
  final double basePrice;
  final String? description;
  final String status;
  final List<ProductImage> productImages;
  final String? defaultImageUrl;

  DeliveryProductModel({
    required this.sku,
    required this.name,
    required this.productWeight,
    required this.reedemWeight,
    required this.metalType,
    required this.purity,
    required this.jewelleryType,
    this.productSize,
    required this.basePrice,
    this.description,
    required this.status,
    required this.productImages,
    this.defaultImageUrl,
  });

  factory DeliveryProductModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryProductModelToJson(this);
}

@JsonSerializable()
class ProductImage {
  final int id;
  final String url;
  final int displayOrder;
  final bool defaultImage;

  ProductImage({
    required this.id,
    required this.url,
    required this.displayOrder,
    required this.defaultImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
