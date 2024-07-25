import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../entities/app_error.dart';
import '../../../data/models/neobaskets/neobaskets_discovery_details.dart';
import '../../entities/params/neobaskets/neobaskets_discovery_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetNeoBasket extends UseCase<List<NeobasketsDiscoveryDetails>, NeobasketDiscoveryParams> {
  final NeobasketsRepository _neobasketsRepository;

  GetNeoBasket(this._neobasketsRepository);

  @override
  Future<Either<AppError, List<NeobasketsDiscoveryDetails>>> call(params) =>
      _neobasketsRepository.getNeoBaskets(params.toJson());
}
