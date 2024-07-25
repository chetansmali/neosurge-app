import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../data/models/user/mandate_sip_model.dart';
import '../../../../../data/models/user/user_bank_mandate_model.dart';
import '../../../../routes/route_arguments.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_colors.dart';

enum _DeleteMandateOptions {
  closeSips,
  moveSips,
}

class DeleteMandateBottomSheet extends StatefulWidget {
  const DeleteMandateBottomSheet({
    super.key,
    required this.sips,
    required this.mandate,
  });

  final List<MandateSipModel> sips;
  final UserBankMandateModel mandate;

  @override
  State<DeleteMandateBottomSheet> createState() =>
      _DeleteMandateBottomSheetState();
}

class _DeleteMandateBottomSheetState extends State<DeleteMandateBottomSheet> {
  _DeleteMandateOptions _selectedOption = _DeleteMandateOptions.closeSips;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Before deleting the mandate, I want to',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const Gap(34),
          RadioListTile.adaptive(
            value: _DeleteMandateOptions.closeSips,
            groupValue: _selectedOption,
            title: Text(
              'Close all SIPs linked to it',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.neutral[500],
              ),
            ),
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {
                _selectedOption = value ?? _DeleteMandateOptions.closeSips;
              });
            },
          ),
          RadioListTile.adaptive(
            value: _DeleteMandateOptions.moveSips,
            groupValue: _selectedOption,
            title: Text(
              'Move all SIPs linked to a new mandate',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.neutral[500],
              ),
            ),
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {
                _selectedOption = value ?? _DeleteMandateOptions.closeSips;
              });
            },
          ),
          const Gap(34),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              maximumSize: const Size(double.infinity, 48),
            ),
            onPressed: () {
              if (_selectedOption == _DeleteMandateOptions.moveSips) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.sipLinkedScreen,
                  arguments: MandateSwitchScreenArgs(
                    mandate: widget.mandate,
                    sips: widget.sips,
                  ),
                );
                return;
              } else if (_selectedOption == _DeleteMandateOptions.closeSips) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.closeAllSipScreen,
                  arguments: MandateCloseAllScreenArgs(
                    sips: widget.sips,
                    mandate: widget.mandate,
                  ),
                );
                return;
              }
            },
            child: const Text(
              'Continue',
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
