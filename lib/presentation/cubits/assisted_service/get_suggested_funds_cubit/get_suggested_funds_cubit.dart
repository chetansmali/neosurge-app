import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/assisted_service/suggested_fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/assisted_service/get_suggested_funds_params.dart';
import '../../../../domain/usecases/assisted_service/get_suggested_funds.dart';

part 'get_suggested_funds_state.dart';

@injectable
class GetSuggestedFundsCubit extends Cubit<GetSuggestedFundsState> {
  final GetSuggestedFunds _getSuggestedFunds;

  GetSuggestedFundsCubit(this._getSuggestedFunds) : super(GetSuggestedFundsInitial());

  int _suggestionCount = 1;

  void getSuggestedFunds({required double amount, required int tenure, required int userId}) async {
    emit(GetSuggestedFundsLoading());
    final result = await _getSuggestedFunds(GetSuggestedFundsParams(amount: amount, tenure: tenure, userId: userId, suggestCount: _suggestionCount));
    emit(
      result.fold(
        (l) => GetSuggestedFundsError(l.error, l.errorType),
        (r) {
          _suggestionCount++;
          return GetSuggestedFundsLoaded(r);
        },
      ),
    );
  }
}
