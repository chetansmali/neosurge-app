// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nominee_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NomineeEntity _$NomineeEntityFromJson(Map<String, dynamic> json) =>
    NomineeEntity(
      id: json['id'] as int?,
      nomineeFullName: json['nomineeFullName'] as String,
      nomineeDateOfBirth: DateTime.parse(json['nomineeDateOfBirth'] as String),
      guardianName: json['guardianName'] as String?,
      guardianRelationshipId: json['guardianRelationshipId'] as int?,
      nomineeRelationTypeId: json['nomineeRelationTypeId'] as int?,
      allocationPercentage: (json['allocationPercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$NomineeEntityToJson(NomineeEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['nomineeFullName'] = instance.nomineeFullName;
  val['nomineeDateOfBirth'] =
      NomineeEntity.dateOfBirthToString(instance.nomineeDateOfBirth);
  writeNotNull('guardianName', instance.guardianName);
  writeNotNull('guardianRelationshipId', instance.guardianRelationshipId);
  writeNotNull('nomineeRelationTypeId', instance.nomineeRelationTypeId);
  val['allocationPercentage'] = instance.allocationPercentage;
  return val;
}
