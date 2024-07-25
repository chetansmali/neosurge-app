import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../common/extensions.dart';
import '../../widgets/custom_container.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../common/custom_styles.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/keyboard_dismiss_btn.dart';

class RetirementAgeScreen extends StatefulWidget {
  final int income;
  final int expence;
  final int saving;
  final String selectedOption;
  final String isSafe;
  const RetirementAgeScreen(
      {super.key,
      required this.income,
      required this.expence,
      required this.saving,
      required this.selectedOption,
      required this.isSafe});

  @override
  State<RetirementAgeScreen> createState() => _RetirementAgeScreenState();
}

class _RetirementAgeScreenState extends State<RetirementAgeScreen> {
  int _age = 50;
  TextEditingController ageController = TextEditingController(text: '50');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Retirement Age',
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GradientText(
                          'When do you wish to retire?',
                          gradient: const LinearGradient(
                            colors: [Colors.black87, Color(0xFF0046D2)],
                          ),
                          style: baseTextStyle14600.copyWith(fontSize: 28),
                        ),
                        const Gap(50),
                        CircularPercentIndicator(
                          radius: 70,
                          percent: _age / 100,
                          animation: true,
                          animateFromLastPercent: true,
                          animationDuration: 1000,
                          lineWidth: 10,
                          center: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Your retirement age is ',
                                    style: baseTextStyle12400.copyWith(
                                        color: AppColors.mainBlack),
                                  ),
                                  TextSpan(
                                    text: ' $_age ',
                                    style: baseTextStyle14400.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                  // TextSpan(
                                  //   text: 'years away from retirement',
                                  //   style: baseTextStyle12400.copyWith(
                                  //       color: AppColors.mainBlack),
                                  // ),
                                ])),
                          ),
                          progressColor: AppColors.green,
                          backgroundColor: AppColors.green.withOpacity(0.4),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        const Gap(40),
                        Slider.adaptive(
                          activeColor: AppColors.primaryColor,
                          inactiveColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          value: _age.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              _age = value.toInt();
                              ageController.text = _age.toString();
                            });
                          },
                          min: 1,
                          max: 100,
                        ),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: TextFormField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2)
                            ],
                            onFieldSubmitted: (value) {
                              if (value.removeCommas < 1) {
                                setState(() {
                                  _age = 1;
                                });
                              } else {
                                setState(() {
                                  _age = int.parse(ageController.text);
                                });
                              }
                            },
                          ),
                        ),
                        const Gap(60),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.planYourFutureScreen,
                                arguments: RetirementCorpusArgs(
                                    monthlyIncome: widget.income,
                                    postRetirementStyle: widget.selectedOption,
                                    monthlyExpense: widget.expence,
                                    investmentStyle: widget.isSafe,
                                    existingSavings: widget.saving,
                                    retirementAge: _age,
                                    requestID: ''));
                          },
                          child: Text(
                            'Plan my future',
                            style: baseTextStyle16500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          KeyboardDismissButton(
            onDone: () {
              if (ageController.text.removeCommas < 1) {
                setState(() {
                  _age = 1;
                });
              } else {
                setState(() {
                  _age = int.parse(ageController.text);
                });
              }
              FocusScope.of(context).unfocus();
            },
            buildContext: context,
          ),
        ],
      ),
    );
  }
}
