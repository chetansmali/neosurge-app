import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/initiate_payment_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/initiate_lumpsum_purchase_params.dart';
import '../../../../domain/usecases/mutual_funds/initiate_lumpsum_purchase.dart';
import '../../util_cubits/loading_cubit.dart';

part 'initiate_lumpsum_purchase_state.dart';

@injectable
class InitiateLumpsumPurchaseCubit extends Cubit<InitiateLumpsumPurchaseState> {
  final InitiateLumpsumPurchase _initiateLumpsumPurchase;
  final LoadingCubit _loadingCubit;

  InitiateLumpsumPurchaseCubit(this._initiateLumpsumPurchase, this._loadingCubit) : super(InitiateLumpsumPurchaseInitial());

  void initiateLumpsumPurchase({required int userId, required int mfId}) async {
    _loadingCubit.show();
    emit(InitiateLumpsumPurchaseLoading());
    final res = await _initiateLumpsumPurchase(InitiateLumpsumPurchaseParams(
      userId: userId,
      id: mfId,
      paymentType: MFPaymentTypes.netbanking,
    ));
    res.fold(
      (l) => emit(InitiateLumpsumPurchaseFailure(errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(InitiateLumpsumPurchaseSuccess(response: r)),
    );
    _loadingCubit.hide();
  }
}
