import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/generate_capital_gain_file.dart';
import '../../../../domain/usecases/mutual_funds/generate_capital_gains_file.dart';

part 'generate_capital_gains_file_state.dart';

@injectable
class GenerateCapitalGainsFileCubit
    extends Cubit<GenerateCapitalGainsFileState> {
  final GenereteCapitalGainsFile genereteCapitalGainsFile;
  GenerateCapitalGainsFileCubit(this.genereteCapitalGainsFile)
      : super(GenerateCapitalGainsFileInitial());

  Future fetchCapitalGainFiles(GenerateCapitalGainFileParams params) async {
    emit(GenerateCapitalGainsFileLoading());
    final response = await genereteCapitalGainsFile(params);
    response.fold(
        (l) => emit(
              GenerateCapitalGainsFileFailure(
                  errorMessage: l.error, appErrorType: l.errorType),
            ),
        (r) => emit(
              GenerateCapitalGainsFileSuccess(),
            ));
  }
}
