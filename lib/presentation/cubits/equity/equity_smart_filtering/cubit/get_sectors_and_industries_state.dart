part of 'get_sectors_and_industries_cubit.dart';

abstract class GetSectorsAndIndustriesState extends Equatable {
  const GetSectorsAndIndustriesState();
}

final class GetSectorsAndIndustriesInitial
    extends GetSectorsAndIndustriesState {
  @override
  List<Object> get props => [];
}

class GetSectorsAndIndustriesLoading extends GetSectorsAndIndustriesState {
  @override
  List<Object> get props => [];
}

class GetSectorsAndIndustriesSuccess extends GetSectorsAndIndustriesState {
  final List<GetSectorIndustriesDetails> getSectorIndustriesDetails;
  const GetSectorsAndIndustriesSuccess(this.getSectorIndustriesDetails);
  @override
  List<Object> get props => [getSectorIndustriesDetails];
}

class GetSectorsAndIndustriesFailure extends GetSectorsAndIndustriesState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetSectorsAndIndustriesFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
