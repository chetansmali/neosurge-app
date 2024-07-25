import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fp_fund_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_fund_by_isin_params.dart';
import '../../../../domain/usecases/mutual_funds/get_fp_fund_details.dart';

part 'fp_fund_details_state.dart';

@injectable
class FpFundDetailsCubit extends Cubit<FpFundDetailsState> {
  final GetFpFundDetails _getFpFundDetails;

  FpFundDetailsCubit(this._getFpFundDetails) : super(FpFundDetailsInitial());

  void fetchFpFundDetails({required String isin}) async {
    emit(FpFundDetailsLoading());
    final res = await _getFpFundDetails(GetMutualFundByIsinParams(isin: isin));
    if (isClosed) return;
    emit(res.fold((l) => FpFundDetailsError(l.errorType, l.error),
            (r) {
      if(r.fundSchemeId==null){
       return const FpFundDetailsError(AppErrorType.database, 'This fund is not supported by Fp');
      }
      return FpFundDetailsLoaded(r);
    }));
  }
}
