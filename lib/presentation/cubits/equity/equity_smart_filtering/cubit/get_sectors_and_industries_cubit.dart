import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/equity/smart_filtering/get_sector_industries_details.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/no_params.dart';
import '../../../../../domain/usecases/equity/get_sector_and_industries.dart';

part 'get_sectors_and_industries_state.dart';

@Injectable()
class GetSectorsAndIndustriesCubit extends Cubit<GetSectorsAndIndustriesState> {
  final GetSectorAndIndustries _getSectorAndIndustries;
  GetSectorsAndIndustriesCubit(this._getSectorAndIndustries)
      : super(GetSectorsAndIndustriesInitial());
  void getSectorAndIndustry() async {
    emit(GetSectorsAndIndustriesLoading());
    final response = await _getSectorAndIndustries(NoParams());
    emit(response.fold(
        (l) => GetSectorsAndIndustriesFailure(l.error, l.errorType),
        (r) => GetSectorsAndIndustriesSuccess(r)));
  }
}
