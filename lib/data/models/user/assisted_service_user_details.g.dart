// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assisted_service_user_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssistedServiceUserDetailsAdapter
    extends TypeAdapter<AssistedServiceUserDetails> {
  @override
  final int typeId = 2;

  @override
  AssistedServiceUserDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssistedServiceUserDetails(
      id: fields[0] as int,
      amount: fields[1] as double,
      purchasedOn: fields[2] as DateTime,
      orderId: fields[4] as String?,
      isDeleted: fields[6] as bool,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
      isExpired: fields[5] as bool,
      expiresOn: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AssistedServiceUserDetails obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.purchasedOn)
      ..writeByte(3)
      ..write(obj.expiresOn)
      ..writeByte(4)
      ..write(obj.orderId)
      ..writeByte(5)
      ..write(obj.isExpired)
      ..writeByte(6)
      ..write(obj.isDeleted)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssistedServiceUserDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistedServiceUserDetails _$AssistedServiceUserDetailsFromJson(
        Map<String, dynamic> json) =>
    AssistedServiceUserDetails(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      purchasedOn: DateTime.parse(json['purchasedOn'] as String),
      orderId: json['orderId'] as String?,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isExpired: json['isExpired'] as bool,
      expiresOn: DateTime.parse(json['expiresOn'] as String),
    );

Map<String, dynamic> _$AssistedServiceUserDetailsToJson(
        AssistedServiceUserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'purchasedOn': instance.purchasedOn.toIso8601String(),
      'expiresOn': instance.expiresOn.toIso8601String(),
      'orderId': instance.orderId,
      'isExpired': instance.isExpired,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
