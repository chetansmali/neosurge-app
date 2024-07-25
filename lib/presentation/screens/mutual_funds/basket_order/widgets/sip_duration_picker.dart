import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SipDurationPicker extends StatefulWidget {
  const SipDurationPicker({
    super.key,
    required this.defaultSelectedYear,
    required this.defaultSelectedMonth,
  });

  final int defaultSelectedYear;
  final int defaultSelectedMonth;

  @override
  State<SipDurationPicker> createState() => _SipDurationPickerState();
}

class _SipDurationPickerState extends State<SipDurationPicker> {
  late int _selectedYear;
  late int _selectedMonth;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _selectedYear = widget.defaultSelectedYear;
    _selectedMonth = widget.defaultSelectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: Platform.isAndroid,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMonth = widget.defaultSelectedMonth;
                    });
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: const FaIcon(
                      FontAwesomeIcons.sortDown,
                      size: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Text(
                'Select Duration',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox.shrink(),
            ],
          ),
        ),
        const Gap(5),
        Platform.isIOS
            ? Expanded(
                child: CupertinoDatePicker(
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      _selectedYear = value.year;
                      _selectedMonth = value.month;
                    });
                  },
                  minimumDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month + 6,
                  ),
                  maximumDate: DateTime(
                    DateTime.now().year + 30,
                    DateTime.now().month,
                  ),
                  initialDateTime: DateTime(
                    _selectedYear,
                    _selectedMonth,
                  ),
                  mode: CupertinoDatePickerMode.monthYear,
                ),
              )
            : Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 32,
                      ),
                      itemCount: 30,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () async {
                            setState(() {
                              _selectedYear = DateTime.now()
                                  .add(Duration(days: index * 365))
                                  .year;
                            });

                            await Future.delayed(
                              const Duration(milliseconds: 300),
                            );

                            _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _selectedYear ==
                                      DateTime.now()
                                          .add(Duration(days: index * 365))
                                          .year
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                DateTime.now()
                                    .add(Duration(days: index * 365))
                                    .year
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _selectedYear ==
                                          DateTime.now()
                                              .add(Duration(days: index * 365))
                                              .year
                                      ? Colors.white
                                      : const Color(0xFF47586E),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 20,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 30,
                        crossAxisSpacing: 60,
                        mainAxisSpacing: 40,
                      ),
                      itemCount: 12,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMonth = index + 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _selectedMonth == index + 1
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                DateFormat('MMM')
                                    .format(
                                      DateTime(2000, index + 1),
                                    )
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _selectedMonth == index + 1
                                      ? Colors.white
                                      : const Color(0xFF47586E),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
        Visibility(
          visible: Platform.isIOS,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(
                DateTime(
                  _selectedYear,
                  _selectedMonth,
                ),
              );
            },
            child: const Text('Done'),
          ),
        ),
        const Gap(40),
      ],
    );
  }
}
