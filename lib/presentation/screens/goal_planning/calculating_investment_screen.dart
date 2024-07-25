import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common/custom_styles.dart';
import '../../../domain/entities/nav_tab_entity.dart';
import '../../cubits/util_cubits/nav_cubit.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/custom_container.dart';

class CalculatingInvestmentScreen extends StatefulWidget {
  final double goalAmount;
  const CalculatingInvestmentScreen({super.key, required this.goalAmount});

  @override
  State<CalculatingInvestmentScreen> createState() =>
      _CalculatingInvestmentScreenState();
}

class _CalculatingInvestmentScreenState
    extends State<CalculatingInvestmentScreen> {
  int _amount = 10000;
  String _investmentType = 'SIP';

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      radius: 16,
      child: Column(
        children: [
          Text(
            'Calculate investment required for your goal',
            style: baseTextStyle14400.copyWith(color: AppColors.textGrey),
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _investmentType = 'SIP';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: _investmentType == 'SIP'
                            ? AppColors.primaryColor
                            : AppColors.borderColorGrey),
                    color: _investmentType == 'SIP'
                        ? AppColors.primaryColor.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      'SIP',
                      style: baseTextStyle12500.copyWith(
                          color: _investmentType == 'SIP'
                              ? AppColors.primaryColor
                              : AppColors.mainBlack),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _investmentType = 'Lumpsum';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: _investmentType == 'Lumpsum'
                            ? AppColors.primaryColor
                            : AppColors.borderColorGrey),
                    color: _investmentType == 'Lumpsum'
                        ? AppColors.primaryColor.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      'Lumpsum',
                      style: baseTextStyle12500.copyWith(
                          color: _investmentType == 'Lumpsum'
                              ? AppColors.primaryColor
                              : AppColors.mainBlack),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(24),
          Text(
            'Investment amount',
            style: baseTextStyle12400.copyWith(color: AppColors.textGrey),
          ),
          Slider.adaptive(
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.primaryColor.withOpacity(0.1),
            value: _amount.toDouble(),
            onChanged: (value) {
              setState(() {
                _amount = value.toInt();
              });
            },
            min: 10000,
            max: 10000000,
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.primaryColor,
              ),
            ),
            child: Center(
              child: AmountWidget(
                  amount: _amount.toDouble(),
                  style: baseTextStyle14500,
                  isCompact: false,
                  isDecimal: false),
            ),
          ),
          const Gap(40),
          ElevatedButton(
            onPressed: () {
              context.read<NavCubit>().changeTab(
                    const NavTabEntity(
                      mainTabIndex: 3,
                      mutualFundTabIndex: 1,
                    ),
                  );

              Navigator.pushNamed(
                context,
                Routes.mutualFunds,
              );
            },
            style: ElevatedButton.styleFrom(
              maximumSize: const Size(140, 40),
              minimumSize: const Size(140, 40),
            ),
            child: Text('Invest now',
                style:
                    baseTextStyle14500.copyWith(color: AppColors.primaryWhite)),
          ),
          const Gap(8),
          widget.goalAmount == _amount
              ? Column(
                  children: [
                    const _InvestmentTail(
                      titleOne: 'Your investment will be ',
                      amount: ' ****** ',
                      titleTwo: ' by 20** ',
                      color: AppColors.primaryColor,
                    ),
                    const Gap(8),
                    Text(
                      'Disclaimer: The estimated amount is calculated at 8% rate return',
                      style: baseTextStyle12400.copyWith(
                          color: AppColors.textGrey),
                    )
                  ],
                )
              : widget.goalAmount > _amount
                  ? Column(
                      children: [
                        _InvestmentTail(
                          titleOne: 'You are ',
                          amount: ' ${widget.goalAmount - _amount}',
                          titleTwo: ' short of reaching your goal ',
                          color: AppColors.errorRed,
                        ),
                        const Gap(8),
                        Text(
                          'Disclaimer: The estimated amount is calculated at 8% rate return',
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.textGrey),
                        )
                      ],
                    )
                  : _InvestmentTail(
                      titleOne: 'You are ',
                      amount: ' ${_amount - widget.goalAmount}',
                      titleTwo: ' ahead of reaching your goal ',
                      color: AppColors.green,
                    )
        ],
      ),
    );
  }
}

class _InvestmentTail extends StatelessWidget {
  final String titleOne;
  final String titleTwo;
  final String amount;
  final Color color;

  const _InvestmentTail(
      {required this.titleOne,
      required this.titleTwo,
      required this.amount,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
              text: titleOne,
              style: baseTextStyle14500.copyWith(color: AppColors.textGrey)),
          TextSpan(
            text: '\u20B9',
            style: GoogleFonts.hind(
              textStyle: baseTextStyle16500.copyWith(color: color),
            ),
          ),
          TextSpan(
              text: amount.toString(),
              style: baseTextStyle16500.copyWith(color: color)),
          TextSpan(
              text: titleTwo,
              style: baseTextStyle14500.copyWith(color: AppColors.textGrey)),
        ],
      ),
    );
  }
}
