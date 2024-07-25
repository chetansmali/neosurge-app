class VerifyForgotMPinOtpParams {
  final String otp;

  VerifyForgotMPinOtpParams({required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
    };
  }
}
