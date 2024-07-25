import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/mutual_funds/verify_consent.dart';

import '../../../../domain/repositories/mutual_fund_repository.dart';

part 'verify_consent_state.dart';

@injectable
class VerifyConsentCubit extends Cubit<VerifyConsentState> {
  final MutualFundRepository _mutualFundRepository;

  VerifyConsentCubit(this._mutualFundRepository)
      : super(VerifyConsentInitial());

  void verifyLumpsumConsent(
      {required int consentId, required String otp}) async {
    emit(VerifyConsentLoading());

    final res = await _mutualFundRepository
        .verifyLumpsumConsent({"consentId": consentId, "otp": otp});
    res.fold(
      (l) => emit(VerifyConsentFailed(message: l.error ?? '')),
      (r) => emit(VerifyConsentSuccess(verifyConsentModel: r)),
    );
  }

  void verifySipConsent({required int consentId, required String otp}) async {
    emit(VerifyConsentLoading());

    final res = await _mutualFundRepository
        .verifySipConsent({"consentId": consentId, "otp": otp});
    res.fold(
      (l) => emit(VerifyConsentFailed(message: l.error ?? '')),
      (r) => emit(VerifyConsentSuccess(verifyConsentModel: r)),
    );
  }
}
