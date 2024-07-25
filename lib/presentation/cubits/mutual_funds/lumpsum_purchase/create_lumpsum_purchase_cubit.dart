import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/lumpsum_purchase_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/create_lumpsum_purchase_params.dart';
import '../../../../domain/usecases/mutual_funds/create_lumpsum_purchase.dart';
import '../../util_cubits/loading_cubit.dart';

part 'create_lumpsum_purchase_state.dart';

@injectable
class CreateLumpsumPurchaseCubit extends Cubit<CreateLumpsumPurchaseState> {
  final CreateLumpsumPurchase _createLumpsumPurchase;
  final LoadingCubit _loadingCubit;

  CreateLumpsumPurchaseCubit(this._createLumpsumPurchase, this._loadingCubit) : super(CreateLumpsumPurchaseInitial());

  void createLumpsumPurchase(
      {required String userId,
      required String fundPlanId,
      required double fundAmount,
      String? fundFolioNumber,
      required String isin,
      required double nav,
      required String amcId,
      required int mfLumpsumConsentId,
      required String planName}) async {
    _loadingCubit.show();
    emit(CreateLumpsumPurchaseLoading());
    final res = await _createLumpsumPurchase(CreateLumpsumPurchaseParams(
      userId: userId,
      fundPlanId: fundPlanId,
      fundAmount: fundAmount,
      fundFolioNumber: fundFolioNumber,
      isin: isin,
      nav: nav,
      amcId: amcId,
      planName: planName,
      mfLumpsumConsentId: mfLumpsumConsentId,
    ));
    res.fold(
      (l) => emit(CreateLumpsumPurchaseFailure(errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(CreateLumpsumPurchaseSuccess(lumpsumPurchase: r)),
    );
    _loadingCubit.hide();
  }

  void proceedtoOrderSummary(LumpsumPurchase lumpsumPurchase) {
    emit(ProceedtoOrderSummary(lumpsumPurchase: lumpsumPurchase));
  }
}
