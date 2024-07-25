import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/mutual_funds/redeem/redeem_order_response.dart';
import '../../../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../../domain/entities/params/mutual_funds/create_redemption_order_params.dart';
import '../../../../../domain/usecases/mutual_funds/create_redemption_order.dart';

part 'create_redeem_order_state.dart';

@injectable
class CreateRedeemOrderCubit extends Cubit<CreateRedeemOrderState> {
  final CreateRedemptionOrder _createRedemptionOrder;

  CreateRedeemOrderCubit(
    this._createRedemptionOrder,
  ) : super(CreateRedeemOrderInitial());

  void redeemFund({
    required UserMfScheme scheme,
    double? amount,
    double? units,
    required int userId,
    required bool isAssisted,
    required bool isRedeemAll,
  }) async {
    if (state is CreateRedeemOrderLoading) return;

    emit(CreateRedeemOrderLoading());

    final res = await _createRedemptionOrder(CreateRedemptionOrderParams(
      userId: userId,
      paymentType: MFPaymentTypes.netbanking,
      fundName: scheme.name,
      isinCode: scheme.isin,
      folioNumber: scheme.folioNumber,
      fundAmount: amount,
      fundUnits: units,
      isAssisted: isAssisted,
      isRedeemAll: isRedeemAll,
    ));
    emit(
      res.fold(
        (l) => CreateRedeemOrderFailure(l.error, l.errorType),
        (r) => CreateRedeemOrderSuccess(
          response: r,
        ),
      ),
    );
  }
}
