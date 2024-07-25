import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/mutual_funds/cart/verify_cart_purchase_response.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/verify_cart_purchase_otp_params.dart';
import '../../../../domain/usecases/mutual_funds/verify_cart_purchase_otp.dart';

part 'verify_cart_purchase_otp_status.dart';

@injectable
class VerifyCartPurchaseOtpCubit extends Cubit<VerifyCartPurchaseOtpState> {
  final VerifyCartPurchaseOtp _verifyCartPurchaseOtp;

  VerifyCartPurchaseOtpCubit(this._verifyCartPurchaseOtp)
      : super(const VerifyCartPurchaseOtpInitial());

  void verifyCartPurchaseOtp({
    required VerifyCartPurchaseOtpParams params,
  }) async {
    if (state is VerifyCartPurchaseOtpLoading) return;

    emit(const VerifyCartPurchaseOtpLoading());

    final res = await _verifyCartPurchaseOtp(params);
    res.fold(
      (l) => emit(
        VerifyCartPurchaseOtpFailed(error: l),
      ),
      (r) => emit(
        VerifyCartPurchaseOtpSuccess(verifyCartPurchaseOtpResponse: r),
      ),
    );
  }
}
