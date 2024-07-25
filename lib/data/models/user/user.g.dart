// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      createdAt: fields[0] as DateTime,
      updatedAt: fields[1] as DateTime,
      id: fields[2] as int,
      userName: fields[3] as String?,
      emailId: fields[4] as String,
      mobileNumber: fields[5] as String?,
      emailToken: fields[6] as String?,
      isEmailIdVerified: fields[7] as bool,
      emailVerifiedOn: fields[8] as DateTime?,
      isMobileNumberVerified: fields[9] as bool,
      isActive: fields[10] as bool,
      isDeleted: fields[11] as bool,
      isGoogle: fields[12] as bool,
      mPin: fields[13] as String?,
      isGoldUser: fields[14] as bool,
      isRiskProfileTaken: fields[15] as bool,
      lastRoutedScreen: fields[16] as String?,
      stepCount: fields[17] as int,
      maxStepCount: fields[18] as int,
      profileImage: fields[19] as String?,
      otp: fields[20] as String?,
      counter: fields[21] as int?,
      mPinLastAttempt: fields[22] as DateTime?,
      isAdmin: fields[23] as bool?,
      fcmToken: fields[24] as String?,
      retakeKyc: fields[25] as bool,
      assistedServiceUserDetails: fields[26] as AssistedServiceUserDetails?,
      onboardingBankVerified: fields[27] as bool,
      eSignSubmitDone: fields[28] as bool,
      blocked: fields[29] as bool,
      isOnBoardingCompleted: fields[30] as bool,
      isBiometricEnabled: fields[100] == null ? false : fields[100] as bool,
      showGoldDisclaimer: fields[101] == null ? false : fields[101] as bool,
      panVerified: fields[31] as bool?,
      smallcaseAuthToken: fields[32] as String?,
      equityBroker: fields[33] as String?,
      userGoalsPresent: fields[34] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(37)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.emailId)
      ..writeByte(5)
      ..write(obj.mobileNumber)
      ..writeByte(6)
      ..write(obj.emailToken)
      ..writeByte(7)
      ..write(obj.isEmailIdVerified)
      ..writeByte(8)
      ..write(obj.emailVerifiedOn)
      ..writeByte(9)
      ..write(obj.isMobileNumberVerified)
      ..writeByte(10)
      ..write(obj.isActive)
      ..writeByte(11)
      ..write(obj.isDeleted)
      ..writeByte(12)
      ..write(obj.isGoogle)
      ..writeByte(13)
      ..write(obj.mPin)
      ..writeByte(14)
      ..write(obj.isGoldUser)
      ..writeByte(15)
      ..write(obj.isRiskProfileTaken)
      ..writeByte(16)
      ..write(obj.lastRoutedScreen)
      ..writeByte(17)
      ..write(obj.stepCount)
      ..writeByte(18)
      ..write(obj.maxStepCount)
      ..writeByte(19)
      ..write(obj.profileImage)
      ..writeByte(20)
      ..write(obj.otp)
      ..writeByte(21)
      ..write(obj.counter)
      ..writeByte(22)
      ..write(obj.mPinLastAttempt)
      ..writeByte(23)
      ..write(obj.isAdmin)
      ..writeByte(24)
      ..write(obj.fcmToken)
      ..writeByte(25)
      ..write(obj.retakeKyc)
      ..writeByte(26)
      ..write(obj.assistedServiceUserDetails)
      ..writeByte(27)
      ..write(obj.onboardingBankVerified)
      ..writeByte(28)
      ..write(obj.eSignSubmitDone)
      ..writeByte(29)
      ..write(obj.blocked)
      ..writeByte(30)
      ..write(obj.isOnBoardingCompleted)
      ..writeByte(31)
      ..write(obj.panVerified)
      ..writeByte(32)
      ..write(obj.smallcaseAuthToken)
      ..writeByte(33)
      ..write(obj.equityBroker)
      ..writeByte(34)
      ..write(obj.userGoalsPresent)
      ..writeByte(100)
      ..write(obj.isBiometricEnabled)
      ..writeByte(101)
      ..write(obj.showGoldDisclaimer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as int,
      userName: json['userName'] as String?,
      emailId: json['emailId'] as String,
      mobileNumber: json['mobileNumber'] as String?,
      emailToken: json['emailToken'] as String?,
      isEmailIdVerified: json['isEmailIdVerified'] as bool,
      emailVerifiedOn: json['emailVerifiedOn'] == null
          ? null
          : DateTime.parse(json['emailVerifiedOn'] as String),
      isMobileNumberVerified: json['isMobileNumberVerified'] as bool,
      isActive: json['isActive'] as bool,
      isDeleted: json['isDeleted'] as bool,
      isGoogle: json['isGoogle'] as bool,
      mPin: json['mpin'] as String?,
      isGoldUser: json['isGoldUser'] as bool,
      isRiskProfileTaken: json['isRiskProfileTaken'] as bool,
      lastRoutedScreen: json['lastRoutedScreen'] as String?,
      stepCount: json['stepCount'] as int,
      maxStepCount: json['maxStepCount'] as int,
      profileImage: json['profile_image'] as String?,
      otp: json['otp'] as String?,
      counter: json['counter'] as int?,
      mPinLastAttempt: json['mpinLastAttempt'] == null
          ? null
          : DateTime.parse(json['mpinLastAttempt'] as String),
      isAdmin: json['isAdmin'] as bool?,
      fcmToken: json['fcmToken'] as String?,
      retakeKyc: json['retakeKyc'] as bool,
      assistedServiceUserDetails: json['assistedServiceUserDetailsId'] == null
          ? null
          : AssistedServiceUserDetails.fromJson(
              json['assistedServiceUserDetailsId'] as Map<String, dynamic>),
      onboardingBankVerified: json['onboardingBankVerified'] as bool,
      eSignSubmitDone: json['esignSubmitDone'] as bool,
      blocked: json['blocked'] as bool,
      isOnBoardingCompleted: json['isOnBoardingCompleted'] as bool,
      isBiometricEnabled: json['isBiometricEnabled'] as bool? ?? false,
      showGoldDisclaimer: json['showGoldDisclaimer'] as bool? ?? false,
      panVerified: json['panVerified'] as bool? ?? false,
      smallcaseAuthToken: json['smallcaseAuthToken'] as String?,
      equityBroker: json['equityBroker'] as String?,
      userGoalsPresent: json['userGoalsPresent'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'id': instance.id,
      'userName': instance.userName,
      'emailId': instance.emailId,
      'mobileNumber': instance.mobileNumber,
      'emailToken': instance.emailToken,
      'isEmailIdVerified': instance.isEmailIdVerified,
      'emailVerifiedOn': instance.emailVerifiedOn?.toIso8601String(),
      'isMobileNumberVerified': instance.isMobileNumberVerified,
      'isActive': instance.isActive,
      'isDeleted': instance.isDeleted,
      'isGoogle': instance.isGoogle,
      'mpin': instance.mPin,
      'isGoldUser': instance.isGoldUser,
      'isRiskProfileTaken': instance.isRiskProfileTaken,
      'lastRoutedScreen': instance.lastRoutedScreen,
      'stepCount': instance.stepCount,
      'maxStepCount': instance.maxStepCount,
      'profile_image': instance.profileImage,
      'otp': instance.otp,
      'counter': instance.counter,
      'mpinLastAttempt': instance.mPinLastAttempt?.toIso8601String(),
      'isAdmin': instance.isAdmin,
      'fcmToken': instance.fcmToken,
      'retakeKyc': instance.retakeKyc,
      'assistedServiceUserDetailsId': instance.assistedServiceUserDetails,
      'onboardingBankVerified': instance.onboardingBankVerified,
      'esignSubmitDone': instance.eSignSubmitDone,
      'blocked': instance.blocked,
      'isOnBoardingCompleted': instance.isOnBoardingCompleted,
      'panVerified': instance.panVerified,
      'smallcaseAuthToken': instance.smallcaseAuthToken,
      'equityBroker': instance.equityBroker,
      'userGoalsPresent': instance.userGoalsPresent,
      'isBiometricEnabled': instance.isBiometricEnabled,
      'showGoldDisclaimer': instance.showGoldDisclaimer,
    };
