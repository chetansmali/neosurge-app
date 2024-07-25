import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_fund_by_isin_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mutual_fund_by_isin.dart';

part 'get_fund_by_isin_state.dart';

@injectable
class GetFundByIsinCubit extends Cubit<GetFundByIsinState> {
  final GetMutualFundByIsin _getMutualFundByIsin;

  GetFundByIsinCubit(this._getMutualFundByIsin) : super(GetFundByIsinInitial());

  final List<Fund> _funds = [];

  void getFund({required String isin}) async {
    if (_funds.isNotEmpty && _funds.any((f) => f.isin == isin)) {
      emit(GetFundByIsinLoaded(_funds.firstWhere((f) => f.isin == isin)));
      return;
    }
    emit(GetFundByIsinLoading());
    final res = await _getMutualFundByIsin(GetMutualFundByIsinParams(isin: isin));
    if (isClosed) return;
    emit(res.fold((l) => GetFundByIsinLoadFailure(l.errorType, l.error), (r) {
      _funds.add(r);
      return GetFundByIsinLoaded(r);
    }));
  }
}
