import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/login/equity_brokers.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/equity/get_brokers.dart';

part 'get_all_brokers_state.dart';

@injectable
class GetAllBrokersCubit extends Cubit<GetAllBrokersState> {
  final GetBrokers getBrokers;
  GetAllBrokersCubit(this.getBrokers) : super(GetAllBrokersInitial());

  Future fetchBroker() async {
    emit(GetAllBrokersLoading());
    final response = await getBrokers(NoParams());
    response.fold(
        (l) => emit(GetAllBrokersFailure(
            errorType: l.errorType, errorMessage: l.error)), (r) {
      emit(GetAllBrokersSuccess(brokersModel: r));
    });
  }
}
