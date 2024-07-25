import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/initiate_payment_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/assisted_service/initiate_suggested_funds_payment_params.dart';
import '../../../../domain/usecases/assisted_service/initiate_suggested_funds_payment.dart';
import '../../util_cubits/loading_cubit.dart';

part 'initiate_suggested_funds_payment_state.dart';

@injectable
class InitiateSuggestedFundsPaymentCubit extends Cubit<InitiateSuggestedFundsPaymentState> {
  final InitiateSuggestedFundsPayment _initiateSuggestedFundsPayment;
  final LoadingCubit _loadingCubit;

  InitiateSuggestedFundsPaymentCubit(this._initiateSuggestedFundsPayment, this._loadingCubit) : super(InitiateSuggestedFundsPaymentInitial());

  void initiatePayment({required List<int> transactionIds, required int userId}) async {
    _loadingCubit.show();
    emit(InitiateSuggestedFundsPaymentLoading());
    final res = await _initiateSuggestedFundsPayment(InitiateSuggestedFundsPaymentParams(ids: transactionIds, userId: userId));
    emit(res.fold((l) => InitiateSuggestedFundsPaymentFailure(errorType: l.errorType, errorMessage: l.error), (r) => InitiateSuggestedFundsPaymentSuccess(response: r)));
    _loadingCubit.hide();
  }
}
