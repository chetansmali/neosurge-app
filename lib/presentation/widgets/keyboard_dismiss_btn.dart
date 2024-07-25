import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class KeyboardDismissButton extends StatelessWidget {
  const KeyboardDismissButton({
    super.key,
    required this.onDone,
    this.btnText = 'Done',
    required this.buildContext,
  });

  final BuildContext buildContext;
  final VoidCallback onDone;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(buildContext).viewInsets.bottom > 100
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              color: AppColors.lightGrey,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onDone,
                  child: Text(
                    btnText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryViolet,
                    ),
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
