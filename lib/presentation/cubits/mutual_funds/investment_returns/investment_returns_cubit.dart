import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/investment_returns.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/user_id_param.dart';
import '../../../../domain/usecases/mutual_funds/get_investment_returns.dart';

part 'investment_returns_state.dart';

@injectable
class InvestmentReturnsCubit extends Cubit<InvestmentReturnsState> {
  final GetInvestmentReturns _getInvestmentReturns;

  InvestmentReturnsCubit(this._getInvestmentReturns) : super(InvestmentReturnsInitial());

  Future<void> fetchInvestmentReturns({required int userId}) async {
    if (state is InvestmentReturnsLoading) return;
    emit(InvestmentReturnsLoading());
    final result = await _getInvestmentReturns(UserIdParam(userId: userId));
    result.fold(
      (l) => emit(InvestmentReturnsLoadError(l.errorType, l.error)),
      (r) => emit(InvestmentReturnsLoaded(r)),
    );
    return;
  }

  Future<void> refreshInvestmentReturns({required int userId}) async {
    if (state is InvestmentReturnsLoaded) {
      final investmentReturns = (state as InvestmentReturnsLoaded).investmentReturns;
      final result = await _getInvestmentReturns(UserIdParam(userId: userId));
      emit(result.fold(
        (l) => InvestmentReturnsLoaded(investmentReturns),
        (r) => InvestmentReturnsLoaded(r),
      ));
    } else {
      await fetchInvestmentReturns(userId: userId);
    }
    return;
  }
}
