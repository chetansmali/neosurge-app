import 'package:flutter_test/flutter_test.dart';
import 'package:neosurge/common/common.dart';
import 'package:neosurge/constants/constants.dart';

void main() {
  group('ID Validator Tes', () {
    test('Valid Voter ID Entered', () {
      final res = Validators.validateVoterIDNumber('WKH1186254');
      expect(res, null);
    });
  });

  test('Invalid Voter ID Entered', () {
    final res = Validators.validateVoterIDNumber('WKH118625');
    expect(res, ValidatorStrings.invalidVoterIDNumberField);
  });

  test('Valid Aadhar ID Entered', () {
    final res = Validators.validateAadhaarNumber('993250146632');
    expect(res, null);
  });

  test('Invalid Aadhar ID Entered', () {
    final res = Validators.validateAadhaarNumber('99325014663');
    expect(res, ValidatorStrings.invalidAadharNumberField);
  });

  test('Valid Passport Number Entered', () {
    final res = Validators.validatePassportNumber('A1234567');
    expect(res, null);
  });

  test('Invalid Passport Number Entered', () {
    final res = Validators.validatePassportNumber('A123456');
    expect(res, ValidatorStrings.invalidPassportNumberField);
  });

  test('Valid Driving License Number Entered', () {
    final res = Validators.validateDrivingLicenseNumber('HR06 19850034761');
    expect(res, null);
  });

  test('Invalid Driving License Number Entered', () {
    final res = Validators.validateDrivingLicenseNumber('HR06 198500347623');
    expect(res, ValidatorStrings.invalidDrivingLicenseNumberField);
  });
}
