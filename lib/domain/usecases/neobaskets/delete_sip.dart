import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import 'package:dartz/dartz.dart';

import '../../entities/params/neobaskets/delete_sip_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class DeleteSip extends UseCase<void, DeleteSipParams> {
  final NeobasketsRepository _neobasketsRepository;

  DeleteSip(
    this._neobasketsRepository,
  );

  @override
  Future<Either<AppError, void>> call(DeleteSipParams params) {
    return _neobasketsRepository.deleteSip(params.toJson());
  }
}
