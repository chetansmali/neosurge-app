import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SipDateSelector extends StatefulWidget {
  const SipDateSelector({
    super.key,
    required this.defaultSelectedDate,
  });

  final int defaultSelectedDate;

  @override
  State<SipDateSelector> createState() => _SipDateSelectorState();
}

class _SipDateSelectorState extends State<SipDateSelector> {
  late int selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.defaultSelectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        const Text(
          'Select Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF47586E),
          ),
        ),
        const Gap(20),
        Platform.isIOS
            ? Expanded(
                child: CupertinoPicker.builder(
                  itemExtent: 40,
                  childCount: 28,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedDate - 1,
                  ),
                  onSelectedItemChanged: (int value) {
                    setState(() {
                      selectedDate = value + 1;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Text(
                        '${index + 1}',
                      ),
                    );
                  },
                ),
              )
            : Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 28,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = index + 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedDate == index + 1
                              ? Colors.black
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedDate == index + 1
                                  ? Colors.white
                                  : const Color(0xFF47586E),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(
              selectedDate,
            );
          },
          child: const Text('Done'),
        ),
        const Gap(40),
      ],
    );
  }
}
