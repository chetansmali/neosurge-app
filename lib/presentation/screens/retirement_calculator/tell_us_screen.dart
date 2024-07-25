import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../domain/entities/enums.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/gradient_text.dart';
import '../../../common/custom_styles.dart';
import '../../theme/app_colors.dart';

enum _PostRetirementOption {
  same,
  more,
  less,
}

class TellUsScreen extends StatefulWidget {
  final int income;
  final int expence;
  final int saving;
  const TellUsScreen({
    super.key,
    required this.income,
    required this.expence,
    required this.saving,
  });

  @override
  State<TellUsScreen> createState() => _TellUsScreenState();
}

class _TellUsScreenState extends State<TellUsScreen> {
  RetirementSaving _retirementSaving = RetirementSaving.safe;

  _PostRetirementOption spendPostRetirementOption = _PostRetirementOption.same;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tell us more',
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              radius: 30,
              child: Column(
                children: [
                  GradientText(
                    'Tell us more',
                    gradient: const LinearGradient(
                      colors: [Colors.black87, Color(0xFF0046D2)],
                    ),
                    style: baseTextStyle14600.copyWith(fontSize: 28),
                  ),
                  const Gap(38),
                  Text(
                    'What do your savings look like?',
                    style: baseTextStyle14500,
                  ),
                  const Gap(20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _retirementSaving = RetirementSaving.safe;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _retirementSaving == RetirementSaving.safe
                                  ? Colors.green[700]
                                  : AppColors.greenSecondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      _retirementSaving == RetirementSaving.safe
                                          ? AppColors.mainBlack.withOpacity(0.2)
                                          : Colors.transparent,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Safe',
                                style: baseTextStyle16500.copyWith(
                                    color: Colors.white),
                              ),
                              Text(
                                'PPF, EPF, FD, etc.',
                                style: baseTextStyle12400.copyWith(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        _retirementSaving == RetirementSaving.safe
                            ? const Positioned(
                                right: 25,
                                top: 15,
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 20,
                                  color: AppColors.primaryWhite,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  const Gap(16),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _retirementSaving = RetirementSaving.aggressive;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _retirementSaving ==
                                      RetirementSaving.aggressive
                                  ? AppColors.errorRed
                                  : AppColors.lightRed,
                              boxShadow: [
                                BoxShadow(
                                  color: _retirementSaving ==
                                          RetirementSaving.aggressive
                                      ? AppColors.mainBlack.withOpacity(0.2)
                                      : Colors.transparent,
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Aggressive',
                                style: baseTextStyle16500.copyWith(
                                    color: AppColors.primaryWhite),
                              ),
                              Text(
                                'Equity, Mutual Funds, etc.',
                                style: baseTextStyle12400.copyWith(
                                    color: AppColors.primaryWhite),
                              ),
                            ],
                          ),
                        ),
                        _retirementSaving == RetirementSaving.aggressive
                            ? const Positioned(
                                right: 25,
                                top: 15,
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 20,
                                  color: AppColors.primaryWhite,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  const Gap(34),
                  Text(
                    'How do you want to spend post retirement?',
                    style: baseTextStyle14500,
                  ),
                  const Gap(24),
                  Column(
                    children: <Widget>[
                      RadioListTile.adaptive(
                        value: _PostRetirementOption.same,
                        groupValue: spendPostRetirementOption,
                        onChanged: (value) {
                          setState(() {
                            spendPostRetirementOption = value!;
                          });
                        },
                        title: Text(
                          'Same as today',
                          style: baseTextStyle14400,
                        ),
                      ),
                      RadioListTile.adaptive(
                        title: Text('Spend more', style: baseTextStyle14400),
                        groupValue: spendPostRetirementOption,
                        onChanged: (value) {
                          setState(() {
                            spendPostRetirementOption = value!;
                          });
                        },
                        value: _PostRetirementOption.more,
                      ),
                      RadioListTile.adaptive(
                        title: Text(
                          'Spend less',
                          style: baseTextStyle14400,
                        ),
                        value: _PostRetirementOption.less,
                        groupValue: spendPostRetirementOption,
                        onChanged: (value) {
                          setState(() {
                            spendPostRetirementOption = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.textGrey,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.retirementAgeScreen,
                            arguments: RetirementAgeArgs(
                              saving: widget.saving,
                              income: widget.income,
                              expence: widget.expence,
                              isSafe: _retirementSaving == RetirementSaving.safe
                                  ? 'SAFE'
                                  : 'AGGRESSIVE',
                              selectedOption: spendPostRetirementOption ==
                                      _PostRetirementOption.same
                                  ? 'SAME'
                                  : spendPostRetirementOption ==
                                          _PostRetirementOption.more
                                      ? 'MORE'
                                      : 'LESS',
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.textGrey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
