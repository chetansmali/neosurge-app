import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';

part 'popular_funds_state.dart';

@injectable
class PopularFundsCubit extends Cubit<PopularFundsState> {
  PopularFundsCubit() : super(PopularFundsInitial());

  void getPopularFunds() async {
    emit(PopularFundsLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(PopularFundsLoaded());
  }
}
