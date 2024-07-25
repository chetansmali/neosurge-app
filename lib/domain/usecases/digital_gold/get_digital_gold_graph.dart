import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/digital_gold/digital_gold_graph_response_entity.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class GetDigitalGoldGraph
    extends UseCase<List<DigitalGoldGraphResponse>, NoParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  GetDigitalGoldGraph(this._digitalGoldRepository);

  @override
  Future<Either<AppError, List<DigitalGoldGraphResponse>>> call(
          NoParams params) async =>
      await _digitalGoldRepository.getDigitalGoldGraphData();
}
