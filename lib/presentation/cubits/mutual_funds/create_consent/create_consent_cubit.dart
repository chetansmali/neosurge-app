import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/create_consent.dart';
import '../../../../domain/repositories/mutual_fund_repository.dart';

part 'create_consent_state.dart';

@injectable
class CreateConsentCubit extends Cubit<CreateConsentState> {
  final MutualFundRepository _mutualFundRepository;

  CreateConsentCubit(this._mutualFundRepository)
      : super(CreateConsentInitial());

  void createLumpsumConsent() async {
    if (state is CreateConsentLoading) return;

    emit(CreateConsentLoading());

    final res = await _mutualFundRepository.createLumpsumConsent({});

    res.fold(
      (l) => emit(
        CreateConsentFailed(message: l.error ?? ''),
      ),
      (r) => emit(
        CreateConsentSuccess(createConsentModel: r),
      ),
    );
  }

  void createSipConsent() async {
    if (state is CreateConsentLoading) return;

    emit(CreateConsentLoading());

    final res = await _mutualFundRepository.createSipConsent({});
    res.fold(
      (l) => emit(
        CreateConsentFailed(message: l.error ?? ''),
      ),
      (r) => emit(
        CreateConsentSuccess(createConsentModel: r),
      ),
    );
  }
}
