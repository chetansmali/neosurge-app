import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../gen/assets.gen.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../theme/app_colors.dart';
import '../onboarding/widgets/stepper_icon.dart';

class NonKycFlowStepper extends StatefulWidget {
  const NonKycFlowStepper({Key? key}) : super(key: key);

  @override
  State<NonKycFlowStepper> createState() => _NonKycFlowStepperState();
}

class _NonKycFlowStepperState extends State<NonKycFlowStepper> {
  late final ItemScrollController _itemScrollController;

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _itemScrollController.jumpTo(index: context.read<OnboardingPageCubit>().state.pageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingPageCubit, OnboardingPageState>(
      listener: (context, state) {
        if (state is OnboardingPageChanged) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _itemScrollController.scrollTo(
              index: state.pageIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 90,
          child: ScrollablePositionedList.separated(
              itemCount: 14,
              itemScrollController: _itemScrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final bool isCompleted = index < state.pageIndex;
                if (index == 13) {
                  return const SizedBox(
                    width: 100,
                  );
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Column(
                    children: [
                      const Gap(20),
                      DottedLine(
                        dashLength: 5,
                        lineThickness: 2,
                        dashColor: isCompleted ? AppColors.green : AppColors.primaryColor,
                      ),
                      const Gap(20),
                      _TextGetter(index: index, isCompleted: isCompleted),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                final bool isCompleted = index < state.pageIndex;
                return _IconGetter(
                  index: index,
                  isCompleted: isCompleted,
                );
              }),
        );
      },
    );
  }
}

class _TextGetter extends StatelessWidget {
  final int index;
  final bool isCompleted;

  const _TextGetter({
    Key? key,
    required this.index,
    this.isCompleted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getText(index),
      style: TextStyle(
        color: isCompleted ? AppColors.green : AppColors.primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      ),
    );
  }

  String getText(int index) {
    switch (index) {
      case 0:
        return "Enter PAN Details";
      case 1:
        return "POI";
      case 2:
        return "Personal Details";
      case 3:
        return "Fatca Details";
      case 4:
        return "Address Details";
      case 5:
        return "POA";
      case 6:
        return "Nominee Details";
      // case 7:
      //   return "Bank Cheque";
      case 7:
        return "Bank Details";
      case 8:
        return "Digital Signature";
      case 9:
        return "POI";
      case 10:
        return "POI";
      case 11:
        return "Aadhaar Verification";
      case 12:
        return "E-Sign";
      default:
        return "";
    }
  }
}

class _IconGetter extends StatelessWidget {
  final int index;
  final bool isCompleted;

  const _IconGetter({
    Key? key,
    required this.index,
    this.isCompleted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepperIcon(
      text: 'Step ${index + 1}/13',
      icon: getIcon(index),
      isCompleted: isCompleted,
    );
  }

  SvgPicture getIcon(int index) {
    const double width = 24;
    const double height = 24;
    switch (index) {
      case 0:
        return Assets.icons.idCard.svg(width: width, height: height);
      case 1:
        return Assets.icons.proofOfId.svg(width: width, height: height);
      case 2:
        return Assets.icons.resume.svg(width: width, height: height);
      case 3:
        return Assets.icons.fatca.svg(width: width, height: height);
      case 4:
        return Assets.icons.location.svg(width: width, height: height);
      case 5:
        return Assets.icons.location.svg(width: width, height: height);
      case 6:
        return Assets.icons.addAccount.svg(width: width, height: height);
      // case 7:
      //   return Assets.icons.bankCheque.svg(width: width, height: height, color: Colors.white);
      case 7:
        return Assets.icons.bank.svg(width: width, height: height);
      case 8:
        return Assets.icons.signature.svg(width: width, height: height);
      case 9:
        return Assets.icons.camera.svg(width: width, height: height);
      case 10:
        return Assets.icons.webcam.svg(width: width, height: height);
      case 11:
        return Assets.icons.adhaar.svg(width: width, height: height);
      case 12:
        return Assets.icons.adhaar.svg(width: width, height: height);
      default:
        return Assets.icons.addAccount.svg(width: width, height: height);
    }
  }
}
