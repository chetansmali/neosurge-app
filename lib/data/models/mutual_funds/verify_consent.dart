// To parse this JSON data, do
//
//     final verifyConsentModel = verifyConsentModelFromJson(jsonString);


class VerifyConsentModel {
  VerifyConsentModel({
    required this.id,
    required this.otp,
    required this.isOtpVerified,
    this.folio,
    required this.mobile,
    required this.countryCode,
    this.messageId,
    required this.user,
    required this.isDeleted,
  });

  int id;
  String otp;
  bool isOtpVerified;
  dynamic folio;
  String mobile;
  String countryCode;
  dynamic messageId;
  User user;
  bool isDeleted;

  factory VerifyConsentModel.fromJson(Map<String, dynamic> json) => VerifyConsentModel(
    id: json["id"],
    otp: json["otp"],
    isOtpVerified: json["isOtpVerified"],
    folio: json["folio"],
    mobile: json["mobile"],
    countryCode: json["countryCode"],
    messageId: json["messageId"],
    user: User.fromJson(json["user"]),
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "otp": otp,
    "isOtpVerified": isOtpVerified,
    "folio": folio,
    "mobile": mobile,
    "countryCode": countryCode,
    "messageId": messageId,
    "user": user.toJson(),
    "isDeleted": isDeleted,
  };
}

class User {
  User({
    required this.id,
    required this.userName,
    required this.mobileNumber,
    this.otp,
    required this.fcmToken,
  });

  int id;
  String userName;
  String mobileNumber;
  dynamic otp;
  String fcmToken;


  factory User.fromJson(Map<String, dynamic> json) => User(

    id: json["id"],
    userName: json["userName"],
    mobileNumber: json["mobileNumber"],
    otp: json["otp"],
    fcmToken: json["fcmToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "mobileNumber": mobileNumber,
    "otp": otp,
    "fcmToken": fcmToken,
  };
}

