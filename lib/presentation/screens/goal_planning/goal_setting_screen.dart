import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../common/common.dart';
import '../../../domain/entities/params/goal_planning/create_custom_goals_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/goal_planning/create_user_goals_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';
import '../../widgets/keyboard_dismiss_btn.dart';

class GoalSettingScreen extends StatefulWidget {
  final String goalName;
  final String goalType;
  const GoalSettingScreen(
      {super.key, required this.goalName, required this.goalType});

  @override
  State<GoalSettingScreen> createState() => _GoalSettingScreenState();
}

class _GoalSettingScreenState extends State<GoalSettingScreen> {
  int _amount = 10000;
  TextEditingController ageController = TextEditingController(text: '10000');

  DateTime dateSelected = DateTime.now();
  String formattedDay = DateFormat('dd').format(DateTime.now());
  String formattedMonth = DateFormat('MM').format(DateTime.now());
  String formattedYear = DateTime.now().year.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.goalName,
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Set your goal amount',
                  style: baseTextStyle14400,
                ),
                const Gap(12),
                AmountWidget(
                  amount: _amount.toDouble(),
                  isCompact: false,
                  isDecimal: false,
                  style: baseTextStyle3.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500),
                ),
                const Gap(20),
                Slider.adaptive(
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.primaryColor.withOpacity(0.1),
                  value: _amount.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _amount = value.toInt();
                      ageController.text = _amount.toString();
                    });
                  },
                  min: 10000,
                  max: 10000000,
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [LengthLimitingTextInputFormatter(8)],
                    onFieldSubmitted: (value) {
                      if (int.parse(ageController.text) >= 10000000) {
                        setState(() {
                          _amount = 10000000;
                        });
                      } else {
                        setState(() {
                          _amount = int.parse(ageController.text);
                        });
                      }
                    },
                  ),
                ),
                const Gap(70),
                Text(
                  'Set your goal date',
                  style: baseTextStyle14400.copyWith(color: AppColors.textGrey),
                ),
                const Gap(10),
                InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                              height: 190,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 180,
                                    child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
                                        onDateTimeChanged: (val) {
                                          setState(() {
                                            dateSelected = val;
                                          });
                                          formattedDay = DateFormat('dd')
                                              .format(dateSelected);
                                          formattedMonth = DateFormat('MM')
                                              .format(dateSelected);
                                          formattedYear = DateFormat('yyyy')
                                              .format(dateSelected);
                                        }),
                                  ),
                                ],
                              ),
                            ));
                  },
                  splashColor: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ShowDate(dateSelected: formattedDay, datetimeType: 'DD'),
                      _ShowDate(
                          dateSelected: formattedMonth, datetimeType: 'MM'),
                      _ShowDate(
                          dateSelected: formattedYear, datetimeType: 'YYYY'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          KeyboardDismissButton(
            onDone: () {
              if (int.parse(ageController.text) >= 10000000) {
                setState(() {
                  _amount = 10000000;
                });
              } else {
                setState(() {
                  _amount = int.parse(ageController.text);
                });
              }
            },
            buildContext: context,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            context.read<CreateUserGoalsCubit>().createGoals(
                CreateCustomGoalsParams(
                    goalName: widget.goalName,
                    targetedGoalDate:
                        '$formattedYear-$formattedMonth-$formattedDay',
                    goalType: widget.goalType,
                    targetGoalAmount: _amount.toDouble()));
          },
          style: ElevatedButton.styleFrom(
            maximumSize: const Size(double.infinity, 50),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: BlocConsumer<CreateUserGoalsCubit, CreateUserGoalsState>(
            listener: (context, state) {
              if (state is CreateUserGoalsLoaded) {
                Navigator.popAndPushNamed(
                  context,
                  Routes.goalPlanDashboardScreen,
                  arguments: GoalDashboardArgs(
                    goalName: widget.goalName,
                    id: state.createCustomGoalModel.id.toString(),
                  ),
                );
                Utils.showSuccessAlert(context, 'Goal created successfully');
              }
            },
            builder: (context, state) {
              return state is CreateUserGoalsLoading
                  ? Assets.animations.loading.lottie()
                  : Text(
                      'Create goal',
                      style: baseTextStyle16500.copyWith(
                          color: AppColors.primaryWhite),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _ShowDate extends StatelessWidget {
  final String dateSelected;
  final String datetimeType;
  const _ShowDate({required this.dateSelected, required this.datetimeType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.borderColorGrey,
              width: 1,
            ),
          ),
          child: Text(
            dateSelected,
            style: baseTextStyle3.copyWith(
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
              fontSize: 32,
            ),
          ),
        ),
        Text(
          datetimeType,
          style: baseTextStyle12500.copyWith(color: AppColors.textGrey),
        )
      ],
    );
  }
}
