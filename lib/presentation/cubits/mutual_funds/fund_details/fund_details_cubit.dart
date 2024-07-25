import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fund_detail.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_fund_details_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mutual_fund_details.dart';

part 'fund_details_state.dart';

@injectable
class FundDetailsCubit extends Cubit<FundDetailsState> {
  final GetMutualFundDetail _getMutualFundDetail;

  FundDetailsCubit(this._getMutualFundDetail) : super(FundDetailsInitial());

  void getFundDetails({required String schemeCode}) async {
    emit(FundDetailsLoading());
    final res = await _getMutualFundDetail(
      GetMutualFundDetailsParams(
        schemeCode: schemeCode,
        holdingPeriod: '',
      ),
    );
    if (isClosed) return;
    emit(
      res.fold(
        (l) => FundDetailsLoadFailure(errorType: l.errorType, error: l.error),
        (r) => FundDetailsLoaded(fundDetail: r),
      ),
    );
  }
}
