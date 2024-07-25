part of 'nav_cubit.dart';

abstract class NavState extends Equatable {
  final NavTabEntity navTabEntity;

  const NavState({required this.navTabEntity});
}

class NavChanged extends NavState {
  const NavChanged({required NavTabEntity navTabEntity}) : super(navTabEntity: navTabEntity);

  @override
  List<Object> get props => [navTabEntity];
}
