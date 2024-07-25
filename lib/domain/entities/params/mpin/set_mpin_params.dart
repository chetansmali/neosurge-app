class SetMPinParams {
  final String emailAddress;
  final String mPin;

  SetMPinParams({required this.emailAddress, required this.mPin});

  Map<String, dynamic> toJson() => {
        'emailAddress': emailAddress,
        'mpin': mPin,
      };
}
