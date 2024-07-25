import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../constants/constants.dart';
import 'assisted_service_user_details.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeIds.userTypeId)
class User extends Equatable {
  @HiveField(0)
  final DateTime createdAt;
  @HiveField(1)
  final DateTime updatedAt;
  @HiveField(2)
  final int id;
  @HiveField(3)
  final String? userName;
  @HiveField(4)
  final String emailId;
  @HiveField(5)
  final String? mobileNumber;
  @HiveField(6)
  final String? emailToken;
  @HiveField(7)
  final bool isEmailIdVerified;
  @HiveField(8)
  final DateTime? emailVerifiedOn;
  @HiveField(9)
  final bool isMobileNumberVerified;
  @HiveField(10)
  final bool isActive;
  @HiveField(11)
  final bool isDeleted;
  @HiveField(12)
  final bool isGoogle;
  @JsonKey(name: 'mpin')
  @HiveField(13)
  final String? mPin;
  @HiveField(14)
  final bool isGoldUser;
  @HiveField(15)
  final bool isRiskProfileTaken;
  @HiveField(16)
  final String? lastRoutedScreen;
  @HiveField(17)
  final int stepCount;
  @HiveField(18)
  final int maxStepCount;
  @JsonKey(name: 'profile_image')
  @HiveField(19)
  final String? profileImage;
  @HiveField(20)
  final String? otp;
  @HiveField(21)
  final int? counter;
  @JsonKey(name: 'mpinLastAttempt')
  @HiveField(22)
  final DateTime? mPinLastAttempt;
  @HiveField(23)
  final bool? isAdmin;
  @HiveField(24)
  final String? fcmToken;
  @HiveField(25)
  final bool retakeKyc;
  @JsonKey(name: 'assistedServiceUserDetailsId')
  @HiveField(26)
  final AssistedServiceUserDetails? assistedServiceUserDetails;
  @HiveField(27)
  final bool onboardingBankVerified;
  @JsonKey(name: 'esignSubmitDone')
  @HiveField(28)
  final bool eSignSubmitDone;
  @HiveField(29)
  final bool blocked;
  @HiveField(30)
  final bool isOnBoardingCompleted;
  @HiveField(31)
  final bool? panVerified;
  @HiveField(32)
  final String? smallcaseAuthToken;
  @HiveField(33)
  final String? equityBroker;
  @HiveField(34)
  final bool? userGoalsPresent;

  ///Local variables to handle local states (starts from 100)

  @HiveField(100, defaultValue: false)
  final bool isBiometricEnabled;
  @HiveField(101, defaultValue: false)
  final bool showGoldDisclaimer;

  const User({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.userName,
    required this.emailId,
    this.mobileNumber,
    this.emailToken,
    required this.isEmailIdVerified,
    this.emailVerifiedOn,
    required this.isMobileNumberVerified,
    required this.isActive,
    required this.isDeleted,
    required this.isGoogle,
    this.mPin,
    required this.isGoldUser,
    required this.isRiskProfileTaken,
    this.lastRoutedScreen,
    required this.stepCount,
    required this.maxStepCount,
    this.profileImage,
    this.otp,
    this.counter,
    this.mPinLastAttempt,
    this.isAdmin,
    this.fcmToken,
    required this.retakeKyc,
    this.assistedServiceUserDetails,
    required this.onboardingBankVerified,
    required this.eSignSubmitDone,
    required this.blocked,
    required this.isOnBoardingCompleted,
    this.isBiometricEnabled = false,
    this.showGoldDisclaimer = false,
    this.panVerified = false,
    this.smallcaseAuthToken,
    this.equityBroker,
    this.userGoalsPresent,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? emailId,
    bool? isEmailIdVerified,
    String? mobileNumber,
    bool? isMobileNumberVerified,
    String? mPin,
    bool? isBiometricEnabled,
    bool? isOnBoardingCompleted,
    bool? eSignSubmitDone,
    bool? isGoldUser,
    bool? showGoldDisclaimer,
    bool? isRiskProfileTaken,
    String? profileImage,
    bool? retakeKyc,
    AssistedServiceUserDetails? assistedServiceUserDetails,
    int? maxStepCount,
    bool? panVerified,
    String? smallcaseAuthToken,
    String? equityBroker,
    bool? userGoalsPresent,
  }) =>
      User(
        createdAt: createdAt,
        updatedAt: updatedAt,
        id: id,
        userName: userName,
        emailId: emailId ?? this.emailId,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        emailToken: emailToken,
        isEmailIdVerified: isEmailIdVerified ?? this.isEmailIdVerified,
        emailVerifiedOn: emailVerifiedOn,
        isMobileNumberVerified:
            isMobileNumberVerified ?? this.isMobileNumberVerified,
        isActive: isActive,
        isDeleted: isDeleted,
        isGoogle: isGoogle,
        mPin: mPin ?? this.mPin,
        isGoldUser: isGoldUser ?? this.isGoldUser,
        isRiskProfileTaken: isRiskProfileTaken ?? this.isRiskProfileTaken,
        lastRoutedScreen: lastRoutedScreen,
        stepCount: stepCount,
        maxStepCount: maxStepCount ?? this.maxStepCount,
        profileImage: profileImage ?? this.profileImage,
        otp: otp,
        counter: counter,
        mPinLastAttempt: mPinLastAttempt,
        isAdmin: isAdmin,
        fcmToken: fcmToken,
        retakeKyc: retakeKyc ?? this.retakeKyc,
        assistedServiceUserDetails:
            assistedServiceUserDetails ?? this.assistedServiceUserDetails,
        onboardingBankVerified: onboardingBankVerified,
        eSignSubmitDone: eSignSubmitDone ?? this.eSignSubmitDone,
        blocked: blocked,
        isOnBoardingCompleted:
            isOnBoardingCompleted ?? this.isOnBoardingCompleted,
        isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
        showGoldDisclaimer: showGoldDisclaimer ?? this.showGoldDisclaimer,
        panVerified: panVerified ?? this.panVerified,
        smallcaseAuthToken: smallcaseAuthToken ?? this.smallcaseAuthToken,
        equityBroker: equityBroker ?? this.equityBroker,
        userGoalsPresent: userGoalsPresent ?? this.userGoalsPresent,
      );

  @override
  List<Object?> get props => [
        createdAt,
        updatedAt,
        id,
        userName,
        emailId,
        mobileNumber,
        emailToken,
        isEmailIdVerified,
        emailVerifiedOn,
        isMobileNumberVerified,
        isActive,
        isDeleted,
        isGoogle,
        mPin,
        isGoldUser,
        isRiskProfileTaken,
        lastRoutedScreen,
        stepCount,
        maxStepCount,
        profileImage,
        otp,
        counter,
        mPinLastAttempt,
        isAdmin,
        fcmToken,
        retakeKyc,
        assistedServiceUserDetails,
        onboardingBankVerified,
        eSignSubmitDone,
        blocked,
        isOnBoardingCompleted,
        isBiometricEnabled,
        showGoldDisclaimer,
        panVerified,
        smallcaseAuthToken,
        equityBroker,
        userGoalsPresent
      ];
}
