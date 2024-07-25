import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../widgets/custom_container.dart';
import '../../../../common/custom_styles.dart';
import '../../../../domain/entities/nav_tab_entity.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/util_cubits/nav_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/gradient_text.dart';

class InvestmentOptionsCard extends StatefulWidget {
  const InvestmentOptionsCard({super.key});

  @override
  State<InvestmentOptionsCard> createState() => _InvestmentOptionsCardState();
}

class _InvestmentOptionsCardState extends State<InvestmentOptionsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // late added here

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            context.read<NavCubit>().changeTab(
                  const NavTabEntity(
                    mainTabIndex: 3,
                    mutualFundTabIndex: 0,
                  ),
                );

            Navigator.pushNamed(
              context,
              Routes.mutualFunds,
            );
          },
          child: CustomContainer(
            radius: 16,
            child: Column(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.primaryColor.withOpacity(0.1),
                  ),
                  child: Assets.pngs.retirementGrandpaaImage.image(
                    height: 40,
                    width: 40,
                  ),
                ),
                const Gap(8),
                Text(
                  'Invest and reach your\n goal with our retirement\n mutual fund basket',
                  textAlign: TextAlign.center,
                  style: baseTextStyle10400.copyWith(
                      color: AppColors.textLightGrey),
                ),
                const Gap(16),
                Divider(
                  thickness: 1,
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View solution',
                      style: baseTextStyle12500.copyWith(
                          color: AppColors.secondaryVioletHover),
                    ),
                    const Gap(5),
                    Assets.svgs.roundArrowRightUp.svg(),
                  ],
                ),
              ],
            ),
          ),
        ),
        CustomContainer(
          radius: 16,
          child: Column(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: AppColors.textGrey,
                    )),
                child: Assets.pngs.retirementNps.image(
                  height: 40,
                  width: 40,
                ),
              ),
              const Gap(8),
              Text(
                'Create a new National  \n Pension Scheme (NPS)\n account',
                textAlign: TextAlign.center,
                style:
                    baseTextStyle10400.copyWith(color: AppColors.textLightGrey),
              ),
              const Gap(16),
              Divider(
                thickness: 1,
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return GradientText(
                    'COMING SOON',
                    gradient: LinearGradient(colors: const [
                      Color(0xFF0046D2),
                      Colors.white,
                      Colors.white,
                      Color(0xFF0046D2)
                    ], stops: [
                      0.0,
                      _controller.value,
                      _controller.value,
                      1.0
                    ]),
                    style: baseTextStyle14500,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
