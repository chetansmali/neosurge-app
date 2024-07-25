import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';

part 'create_kyc_request_state.dart';

@injectable
class CreateKycRequestCubit extends Cubit<CreateKycRequestState> {
  CreateKycRequestCubit() : super(CreateKycRequestInitial());
}
