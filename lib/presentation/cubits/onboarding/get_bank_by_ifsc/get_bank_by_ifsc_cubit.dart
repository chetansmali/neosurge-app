import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/kyc/bank_details_by_ifsc_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/kyc/get_bank_details_by_ifsc_params.dart';
import '../../../../domain/usecases/kyc/get_bank_details_by_ifsc.dart';

part 'get_bank_by_ifsc_state.dart';

@injectable
class GetBankByIfscCubit extends Cubit<GetBankByIfscState> {
  final GetBankDetailsByIfscCode _getBankDetailsByIfscCode;

  GetBankByIfscCubit(this._getBankDetailsByIfscCode) : super(GetBankByIfscInitial());

  void getBankDetailsByIfsc({required String ifscCode}) async {
    emit(GetBankByIfscLoading());
    final res = await _getBankDetailsByIfscCode(GetBankDetailsByIfscParams(ifscCode: ifscCode));
    emit(res.fold((l) => GetBankByIfscFailure(errorType: l.errorType, errorMessage: l.error), (r) => GetBankByIfscSuccess(bank: r)));
  }

  void reset() {
    emit(GetBankByIfscInitial());
  }
}
