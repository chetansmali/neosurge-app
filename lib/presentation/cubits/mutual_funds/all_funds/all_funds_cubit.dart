import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_funds_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mutual_funds.dart';

part 'all_funds_state.dart';

@injectable
class AllFundsCubit extends Cubit<AllFundsState> {
  final GetMutualFunds _getMutualFunds;

  AllFundsCubit(this._getMutualFunds) : super(AllFundsInitial());

  int _offset = 0; //Used for pagination
  final int _fundFetchLimit = 20; //20 funds are being fetched every time

  void getFunds({
    String? query,
    List<String>? amcCode,
    List<String>? assetCategory,
    List<String>? assetSubCategory,
    int? offset,
    List<int>? ratings,
    List<String>? riskProfile,
  }) async {
    if (state is AllFundsLoading) return;

    List<Fund> oldFunds = [];
    if (offset == null) {
      final currentState = state;

      if (currentState is AllFundsLoaded) {
        oldFunds = currentState.fundList;
      } else if (currentState is AllFundsLoadError) {
        oldFunds = currentState.oldFundList;
      }
    } else {
      _offset = offset;
    }
    emit(AllFundsLoading(
      oldFunds,
      isFirstFetch: _offset == 0,
    ));
    final response = await _getMutualFunds(GetMutualFundsParams(
      from: _offset,
      size: _fundFetchLimit,
      //Convert each list element to a comma separated string
      assetCategory: assetCategory?.join(','),
      assetSubCategory: assetSubCategory?.join(','),
      amcCode: amcCode?.join(','),
      ratings: ratings ?? [],
      riskProfile: riskProfile?.join(','),
      holdingPeriod: '',
    ));

    if (isClosed) return;

    response.fold(
      (l) => emit(
        AllFundsLoadError(
          isFirstFetch: _offset == 0,
          oldFundList: oldFunds,
          appErrorType: l.errorType,
        ),
      ),
      (r) {
        List<Fund> newFunds = r;
        if (newFunds.isEmpty) {
          emit(AllFundsLoaded(fundList: oldFunds, isLastPage: true));
        } else {
          _offset += _fundFetchLimit;
          oldFunds.addAll(newFunds);
          emit(AllFundsLoaded(
            fundList: oldFunds,
            isLastPage: newFunds.length < _fundFetchLimit,
          ));
        }
      },
    );
  }
}
