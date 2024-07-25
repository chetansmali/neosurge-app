import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/lamf/get_import_landing_page_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class GetCibilRefresh extends UseCase<GetImportLandingPageResponse, NoParams> {
  final LAMFRepository _lAMFRepository;

  GetCibilRefresh(this._lAMFRepository);

  @override
  Future<Either<AppError, GetImportLandingPageResponse>> call(
          NoParams params) =>
      _lAMFRepository.getCibilRefresh();
}
