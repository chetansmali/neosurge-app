// To parse this JSON data, do
//
//     final createConsentModel = createConsentModelFromJson(jsonString);


class CreateConsentModel {
  CreateConsentModel({
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

  factory CreateConsentModel.fromJson(Map<String, dynamic> json) => CreateConsentModel(
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
    required this.emailId,
    this.password,
    required this.mobileNumber,
    required this.isMobileNumberVerified,
    this.otp,
    required this.blocked,
  });


  int id;
  String userName;
  String emailId;
  dynamic password;
  String mobileNumber;
  bool isMobileNumberVerified;
  dynamic otp;
  bool blocked;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userName: json["userName"],
    emailId: json["emailId"],
    password: json["password"],
    mobileNumber: json["mobileNumber"],
    isMobileNumberVerified: json["isMobileNumberVerified"],
    otp: json["otp"],
    blocked: json["blocked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "emailId": emailId,
    "password": password,
    "mobileNumber": mobileNumber,
    "isMobileNumberVerified": isMobileNumberVerified,
    "otp": otp,
    "blocked": blocked,
  };
}

