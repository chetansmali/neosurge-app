import 'package:equatable/equatable.dart';

class NavTabEntity extends Equatable {
  final int mainTabIndex;
  final int mutualFundTabIndex;
  final int portfolioTabIndex;
  final int digitalGoldTabIndex;
  final int portfolioMFTabIndex;

  const NavTabEntity({
    this.mainTabIndex = 2,
    this.mutualFundTabIndex = 0,
    this.portfolioTabIndex = 0,
    this.digitalGoldTabIndex = 0,
    this.portfolioMFTabIndex = 0,
  });

  //copyWith function

  NavTabEntity copyWith({
    int? mainTabIndex,
    int? mutualFundTabIndex,
    int? portfolioTabIndex,
    int? digitalGoldTabIndex,
    int? portfolioMFTabIndex,
  }) {
    return NavTabEntity(
      mainTabIndex: mainTabIndex ?? this.mainTabIndex,
      mutualFundTabIndex: mutualFundTabIndex ?? this.mutualFundTabIndex,
      portfolioTabIndex: portfolioTabIndex ?? this.portfolioTabIndex,
      digitalGoldTabIndex: digitalGoldTabIndex ?? this.digitalGoldTabIndex,
      portfolioMFTabIndex: portfolioMFTabIndex ?? this.portfolioMFTabIndex,
    );
  }

  @override
  List<Object> get props => [
        mainTabIndex,
        mutualFundTabIndex,
        portfolioTabIndex,
        digitalGoldTabIndex,
        portfolioMFTabIndex,
      ];
}
