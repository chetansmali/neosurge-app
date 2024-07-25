import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/import_external_funds/broker_holdings_fund_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/import_external_fund/get_broker_holding_params.dart';
import '../../../../domain/usecases/import_external_fund/get_broker_holding.dart';

part 'broker_holdings_fund_state.dart';

@injectable
class BrokerHoldingsFundCubit extends Cubit<BrokerHoldingsFundState> {
  final GetBrokerHoldings _getBrokerHoldings;

  BrokerHoldingsFundCubit(
    this._getBrokerHoldings,
  ) : super(BrokerHoldingsFundInitial());

  void getBrokerHoldingsFund({
    required int userId,
    required String brokerName,
  }) async {
    emit(BrokerHoldingsFundLoading());
    final response = await _getBrokerHoldings(
      GetBrokerHoldingParams(
        id: userId,
        brokerName: brokerName,
      ),
    );

    response.fold(
      (l) => emit(
        BrokerHoldingsFundLoadError(
          appErrorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(
        BrokerHoldingsFundLoaded(
          brokerHoldingsFunds: r,
        ),
      ),
    );
  }
}
