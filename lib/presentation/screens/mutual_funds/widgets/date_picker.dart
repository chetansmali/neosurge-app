import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../domain/entities/enums.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';

class DatePicker extends HookWidget {
  final List<int> validDates;
  final TextEditingController dateController;
  final String title;
  final String subtitle;
  final MFTransactionTypes transactionType;

  const DatePicker({Key? key, required this.validDates, required this.dateController, required this.title, required this.subtitle, required this.transactionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState<int>(int.parse(dateController.text.replaceAll(RegExp(r'[^0-9]'), '')));
    DateTime selectedDateObj = transactionType == MFTransactionTypes.sip ? Utils.getNextSipDate(selectedDate.value) : Utils.getNextStpSwpDate(selectedDate.value);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LabelText(label: title),
            ],
          ),
          const Gap(30),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 10, mainAxisSpacing: 20, childAspectRatio: 1.5),
              itemCount: 31,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final date = index + 1;
                return GestureDetector(
                  onTap: _isValidDate(date)
                      ? () {
                          selectedDate.value = date;
                          selectedDateObj = transactionType == MFTransactionTypes.sip ? Utils.getNextSipDate(date) : Utils.getNextStpSwpDate(date);
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedDate.value == date ? AppColors.primaryColor : null,
                    ),
                    child: Center(
                      child: Text(
                        '$date',
                        style: TextStyle(
                          color: _isValidDate(date)
                              ? selectedDate.value == date
                                  ? Colors.white
                                  : AppColors.mainBlack
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
              text: subtitle,
            ),
            TextSpan(
              text: '${Utils.suffixText(selectedDateObj.day)} ${DateFormat('MMMM').format(selectedDateObj)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ])),
          const Gap(20),
          ElevatedButton(
              onPressed: () {
                dateController.text = '${Utils.suffixText(selectedDate.value)} of every month';
                Navigator.of(context).pop(selectedDateObj);
              },
              child: const Text('Confirm')),
          const Gap(20),
        ],
      ),
    );
  }

  bool _isValidDate(int date) => validDates.contains(date);
}
