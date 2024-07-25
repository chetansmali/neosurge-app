import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/resend_transaction_otp_params.dart';
import '../../../../domain/usecases/mutual_funds/resend_transaction_otp.dart';
import '../../util_cubits/loading_cubit.dart';

part 'resend_transaction_otp_state.dart';

@injectable
class ResendTransactionOtpCubit extends Cubit<ResendTransactionOtpState> {
  final ResendTransactionOtp _resendTransactionOtp;
  final LoadingCubit _loadingCubit;

  ResendTransactionOtpCubit(this._resendTransactionOtp, this._loadingCubit) : super(ResendTransactionOtpInitial());

  void resendOtp({required int userId, required int transactionId, required MFTransactionTypes transactionType}) async {
    emit(ResendTransactionOtpLoading());
    _loadingCubit.show();
    final res = await _resendTransactionOtp(ResendTransactionOtpParams(userId: userId, id: transactionId, transactionType: transactionType));
    emit(res.fold((l) => ResendTransactionOtpFailure(l.errorType, l.error), (r) => ResendTransactionOtpSuccess()));
    _loadingCubit.hide();
  }
}
