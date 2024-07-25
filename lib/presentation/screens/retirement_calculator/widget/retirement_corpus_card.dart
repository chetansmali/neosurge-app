import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/common.dart';
import '../../../../di/get_it.dart';
import '../../../cubits/retirement_calculator/generate_retirement_otp_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/custom_container.dart';
import 'retirement_bottom_sheet.dart';
import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class RetirementCorpusCard extends StatefulWidget {
  final double retirementCorpus;
  final double monthlySavings;
  final double goalForTheYear;
  final int monthlyIncome;
  final int retirementAge;
  final int existingSavings;
  final String investmentStyle;
  final int monthlyExpense;
  final String postRetirementStyle;
  final String requestID;
  final double epfTotalCorpus;
  final VoidCallback onClick;

  const RetirementCorpusCard({
    super.key,
    required this.retirementCorpus,
    required this.monthlySavings,
    required this.goalForTheYear,
    required this.monthlyIncome,
    required this.retirementAge,
    required this.requestID,
    required this.existingSavings,
    required this.investmentStyle,
    required this.monthlyExpense,
    required this.postRetirementStyle,
    required this.epfTotalCorpus,
    required this.onClick,
  });

  @override
  State<RetirementCorpusCard> createState() => _RetirementCorpusCardState();
}

class _RetirementCorpusCardState extends State<RetirementCorpusCard> {
  bool isETFOTPvalidate = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          radius: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Retirement Corpus required',
                style: baseTextStyle16500,
              ),
              const Gap(20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.primaryColor.withOpacity(0.1)),
                child: Center(
                  child: AmountWidget(
                    amount: widget.retirementCorpus,
                    style: baseTextStyle32500.copyWith(
                      color: const Color(0xFF133C6B),
                    ),
                  ),
                ),
              ),
              const Gap(20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'To reach your goal, you will have to save \n',
                    style:
                        baseTextStyle14400.copyWith(color: AppColors.mainBlack),
                  ),
                  TextSpan(
                    text: ' \u20B9 ',
                    style: GoogleFonts.hind(
                      textStyle: baseTextStyle16500.copyWith(
                          color: AppColors.primaryColor),
                    ),
                  ),
                  TextSpan(
                      text: (widget.monthlySavings.toStringAsFixed(2)),
                      style: baseTextStyle16500.copyWith(
                          color: AppColors.primaryColor)),
                  TextSpan(
                    text: '  per month',
                    style:
                        baseTextStyle14400.copyWith(color: AppColors.mainBlack),
                  ),
                ]),
              ),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.svgs.retirementGoal.svg(height: 40, width: 40),
                  Text('Goal for 2024: ', style: baseTextStyle12600),
                  AmountWidget(
                    amount: widget.goalForTheYear,
                    isCompact: false,
                    style: baseTextStyle14600.copyWith(color: AppColors.green),
                  )
                ],
              ),
              const Gap(15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.financialDetailsScreens, (route) => true);
                },
                child: Text(
                  'Update my plan',
                  style: baseTextStyle16500.copyWith(
                      color: AppColors.primaryWhite),
                ),
              ),
              const Gap(10),
              widget.epfTotalCorpus == 0
                  ? TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (BuildContext _) {
                            return BlocProvider(
                              create: (context) =>
                                  getIt<GenerateRetirementOtpCubit>(),
                              child: RetirementBottomSheet(
                                  monthlyIncome: widget.monthlyExpense,
                                  monthlyExpense: widget.monthlyExpense,
                                  existingSavings: widget.existingSavings,
                                  investmentStyle: widget.postRetirementStyle,
                                  postRetirementStyle:
                                      widget.postRetirementStyle,
                                  retirementAge: widget.retirementAge),
                            );
                          },
                        );
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                'Do you have EPF holdings? Add them to refine your retirement estimate.',
                            style: baseTextStyle14400.copyWith(
                                color: AppColors.mainBlack),
                          ),
                          TextSpan(
                              text: ' Import now',
                              onEnter: (event) {},
                              style: baseTextStyle14600.copyWith(
                                  color: AppColors.primaryColor))
                        ]),
                      ),
                    )
                  : const Gap(0),
            ],
          ),
        ),
        const Gap(12),
        widget.epfTotalCorpus == 0
            ? const Gap(0)
            : CustomContainer(
                radius: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated EPF Corpus at retirement',
                      style: baseTextStyle14400.copyWith(
                          color: AppColors.textLightGrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AmountWidget(
                              amount: widget.epfTotalCorpus,
                              isCompact: false,
                              style: baseTextStyle16500,
                            ),
                            IconButton(
                              onPressed: widget.onClick,
                              icon: const Icon(
                                Icons.refresh_rounded,
                                size: 18,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.retirementETFDetailsScreen,
                                  arguments: RetirementPassBookArgs(
                                    requestID: widget.requestID,
                                    refreshNeeded: 'false',
                                  ),
                                );
                              },
                              child: Text(
                                'View EPF report',
                                style: baseTextStyle12500.copyWith(
                                    color: AppColors.primaryColor),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_right_outlined,
                              color: AppColors.primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
