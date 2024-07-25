import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/assisted_service/invest_suggested_funds_response.dart';
import '../../../../data/models/assisted_service/suggested_fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/assisted_service/invest_suggested_funds_params.dart';
import '../../../../domain/usecases/assisted_service/invest_suggested_funds.dart';
import '../../util_cubits/loading_cubit.dart';

part 'invest_suggested_funds_state.dart';

@injectable
class InvestSuggestedFundsCubit extends Cubit<InvestSuggestedFundsState> {
  final InvestSuggestedFunds _investSuggestedFunds;
  final LoadingCubit _loadingCubit;

  InvestSuggestedFundsCubit(this._investSuggestedFunds, this._loadingCubit) : super(InvestSuggestedFundsInitial());

  void investSuggestedFunds({required List<SuggestedFund> funds, required int userId, required int consentId}) async {
    _loadingCubit.show();
    emit(InvestSuggestedFundsLoading());
    final result = await _investSuggestedFunds(InvestSuggestedFundsParams(
      userId: userId,
      suggestionList: funds.map((e) => e.toSuggestedFundDetail).toList(),
      mfLumpsumConsentId: consentId,
    ));
    emit(result.fold((l) => InvestSuggestedFundsError(l.error, l.errorType), (r) => InvestSuggestedFundsLoaded(r)));
    _loadingCubit.hide();
  }
}
