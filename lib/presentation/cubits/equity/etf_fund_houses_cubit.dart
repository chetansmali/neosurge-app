import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/no_params.dart';
import '../../../domain/usecases/equity/get_etf_fund_houses.dart';

part 'etf_fund_houses_state.dart';

@injectable
class EtfFundHousesCubit extends Cubit<EtfFundHousesState> {
  final GetETFFundHouses _getETFFundHouses;

  EtfFundHousesCubit(this._getETFFundHouses) : super(EtfFundHousesInitial());

  Future getFundHouses() async {
    emit(EtfFundHousesLoading());

    final response = await _getETFFundHouses.call(NoParams());

    response.fold(
        (l) => emit(EtfFundHousesFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(EtfFundHousesSuccess(etfFundHouses: r)));
  }
}
