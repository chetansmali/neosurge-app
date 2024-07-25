part of 'neobasket_discovery_cubit.dart';

abstract class NeobasketDiscoveryState extends Equatable {
  const NeobasketDiscoveryState();
}

class NeobasketDiscoveryInitial extends NeobasketDiscoveryState {
  @override
  List<Object> get props => [];
}

class NeobasketDiscoveryLoading extends NeobasketDiscoveryState {
  @override
  List<Object> get props => [];
}

class NeobasketDiscoverySuccess extends NeobasketDiscoveryState {
  final List<NeobasketsDiscoveryDetails> neobasketsDiscoveryDetails;

  const NeobasketDiscoverySuccess(this.neobasketsDiscoveryDetails);

  @override
  List<Object> get props => [];
}

class NeobasketDiscoveryFailure extends NeobasketDiscoveryState {
  final String? errorMessage;
  final AppErrorType errorType;

  const NeobasketDiscoveryFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
