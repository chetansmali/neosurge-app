import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_portfolio/get_smallcase_fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_portfolio/get_smallcase_funds.dart';
import '../../../../domain/usecases/equity/get_smallcase_funds.dart';

part 'smallcase_funds_state.dart';

@injectable
class SmallcaseFundsCubit extends Cubit<SmallcaseFundsState> {
  final GetSmallcaseFunds getSmallcaseFunds;

  SmallcaseFundsCubit(this.getSmallcaseFunds) : super(SmallcaseFundsInitial());

  Future fetchSmallcasefunds(GetFundasParams params) async {
    emit(SmallcaseFundsLoading());
    final response = await getSmallcaseFunds(params);
    response.fold(
      (l) => emit(
          SmallcaseFundsFailure(errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(SmallcaseFundsSuccess(r)),
    );
  }
}
