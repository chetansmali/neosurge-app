import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../gen/assets.gen.dart';
import '../cubits/util_cubits/nav_cubit.dart';
import '../routes/routes.dart';
import '../theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final PageController pageController;

  const BottomNavBar({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (_, isVisible) => isVisible
          ? const SizedBox.shrink()
          : BlocConsumer<NavCubit, NavState>(
              listenWhen: (previous, current) =>
                  previous.navTabEntity.mainTabIndex !=
                  current.navTabEntity.mainTabIndex,
              listener: (context, state) {
                pageController.jumpToPage(
                  state.navTabEntity.mainTabIndex,
                );
              },
              buildWhen: (previous, current) =>
                  current.navTabEntity.mainTabIndex !=
                  previous.navTabEntity.mainTabIndex,
              builder: (context, state) {
                return BottomNavigationBar(
                  selectedItemColor: AppColors.mainBlack,
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: AppColors.mainBlack,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: AppColors.mainBlack,
                  ),
                  currentIndex: state.navTabEntity.mainTabIndex,
                  onTap: (index) {
                    HapticFeedback.mediumImpact();
                    if (index == 1) {
                      Navigator.pushNamed(
                        context,
                        Routes.neoCardDiscovery,
                      );

                      return;
                    }
                    context.read<NavCubit>().changeTab(
                          context
                              .read<NavCubit>()
                              .state
                              .navTabEntity
                              .copyWith(mainTabIndex: index),
                        );

                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease,
                    );
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.creditInactive
                            .svg(height: 28, width: 28),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.creditActive
                            .svg(height: 28, width: 28),
                      ),
                      label: 'Credit',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.paymentInactive.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.paymentActive.svg(),
                      ),
                      label: 'Payments',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.homeInactive.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.homeActive.svg(),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.investInactive.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.investActive.svg(),
                      ),
                      label: 'Invest',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child:
                            Assets.icons.bottomNavBar.portfolioInactive.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Assets.icons.bottomNavBar.portfolioActive.svg(),
                      ),
                      label: 'My Portfolio',
                    ),
                  ],
                );
              },
            ),
    );
  }
}
