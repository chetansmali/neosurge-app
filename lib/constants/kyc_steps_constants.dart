// 1. Confirm Pan
// 2. Personal Details
// 3. Fatca Details
// 4. Address Details
// 5. Nominee Details
// 6. Bank Details
// 7. Signature Upload

enum KycCompliantStepsRoutes {
  checkPanStatus('Check Pan Status', -1),
  confirmPan('Confirm Pan', 0),
  personalDetails('Personal Details', 1),
  fatcaDetails('Fatca Details', 2),
  addressDetails('Address Details', 3),
  nomineeDetails('Nominee Details', 4),
  bankDetails('Bank Details', 5),
  signatureUpload('Signature Upload', 6);

  final String name;
  final int value;
  const KycCompliantStepsRoutes(
    this.name,
    this.value,
  );
}

// 1. Check Pan Status
// 3. Pan Upload
// 2. Confirm Pan
// 4. Address Proof Uploded
// 5. Address Details
// 6. Bank Details
// 7. Personal Details
// 8. Fatca Details
// 9. Nominee Details
// 10. User Video Uploded
// 11. Aadhar Number Uploaded
// 12. E Sign
// 13. Signature Upload

enum NonKycFlowRoutes {
  checkPanStatus('Check Pan Status', -1),
  panUpload('Pan Upload', 0),
  confirmPan('Confirm Pan', 1),
  personalDetails('Personal Details', 2),
  addressProofUploded('Address Proof Uploded', 3),
  addressDetails('Address Details', 4),
  bankDetails('Bank Details', 5),
  fatcaDetails('Fatca Details', 6),
  nomineeDetails('Nominee Details', 7),
  userVideoUploded('User Video Uploded', 8),
  aadharNumberUploaded('Aadhar Number Uploaded', 9),
  eSign('E Sign', 10),
  signatureUpload('Signature Upload', 11);

  final String name;
  final int value;

  const NonKycFlowRoutes(this.name, this.value);
}
