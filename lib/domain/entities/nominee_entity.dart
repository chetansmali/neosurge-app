import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nominee_entity.g.dart';

@JsonSerializable(includeIfNull: false)
class NomineeEntity {
  final int? id;
  final String nomineeFullName;
  @JsonKey(toJson: dateOfBirthToString)
  final DateTime nomineeDateOfBirth;
  final String? guardianName;
  final int? guardianRelationshipId;
  final int? nomineeRelationTypeId;
  final double allocationPercentage;

  NomineeEntity({
    this.id,
    required this.nomineeFullName,
    required this.nomineeDateOfBirth,
    this.guardianName,
    this.guardianRelationshipId,
    required this.nomineeRelationTypeId,
    required this.allocationPercentage,
  });

  // : assert(
  //       DateTime.now().year - nomineeDateOfBirth.year < 18 &&
  //           guardianName != null,
  //       throw('Guardian Name cannot be null if nominee age is below 18')),
  //   assert(allocationPercentage >= 0 && allocationPercentage <= 100,
  //       'Percentage must be between 0 and 100');

  factory NomineeEntity.fromJson(Map<String, dynamic> json) =>
      _$NomineeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NomineeEntityToJson(this);

  static String dateOfBirthToString(DateTime dateOfBirth) =>
      DateFormat('yyyy-MM-dd').format(dateOfBirth);
}
