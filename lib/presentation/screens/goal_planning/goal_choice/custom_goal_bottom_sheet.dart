import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/common.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class CustomGoalBottomSheet extends StatefulWidget {
  final String goalType;
  const CustomGoalBottomSheet({super.key, required this.goalType});

  @override
  State<CustomGoalBottomSheet> createState() => _CustomGoalBottomSheetState();
}

class _CustomGoalBottomSheetState extends State<CustomGoalBottomSheet> {
  final TextEditingController _textEditingController = TextEditingController();
  final goalFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Goal name',
                  style: baseTextStyle14400,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const Gap(8),
            Form(
              key: goalFormkey,
              child: TextFormField(
                controller: _textEditingController,
                textInputAction: TextInputAction.done,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter goal name';
                  }
                  return null;
                },
                autofocus: true,
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.textGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.textGrey),
                  ),
                ),
              ),
            ),
            const Gap(26),
            ElevatedButton(
              onPressed: () {
                if (goalFormkey.currentState!.validate()) {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.goalSettingScreen,
                    arguments: GoalSettingArgs(
                        goalName: _textEditingController.text,
                        goalType: widget.goalType),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(double.infinity, 50),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
