import '../../nominee_entity.dart';

class UploadNomineeDetailsParams {
  final List<NomineeEntity> nomineeData;

  UploadNomineeDetailsParams({required this.nomineeData})
      : assert(
            //The sum of allocation percentage of all nominees should be 100

            nomineeData.fold(
                    0,
                    (num prev, current) =>
                        prev + current.allocationPercentage) ==
                100);

  factory UploadNomineeDetailsParams.fromJson(Map<String, dynamic> json) {
    return UploadNomineeDetailsParams(
        nomineeData: (json['nomineeData'] as List)
            .map((e) => NomineeEntity.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() =>
      {'nomineeData': nomineeData.map((e) => e.toJson()).toList()};
}
