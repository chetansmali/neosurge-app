import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';

class HowItWorks extends StatefulWidget {
  const HowItWorks({super.key});

  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
  bool isSliderVisible = false;
  final int initialPage =
      10000; // A large enough number to simulate an infinite loop
  late PageController pageController = PageController();
  List<Widget> listHIW = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eligibility',
          style: baseTextStyle16500,
        ),
        const Gap(8),
        Row(
          children: [
            Text(
              '• 18-65',
              style: baseTextStyle12400.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              ' years of age',
              style: baseTextStyle12400,
            ),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            Text(
              '• Self-employed/Salaried ',
              style: baseTextStyle12400.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Indian resident',
              style: baseTextStyle12400,
            ),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            Text(
              '• Hold MFs approved with',
              style: baseTextStyle12400,
            ),
            Text(
              ' CAMS & KFintech',
              style: baseTextStyle12400.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Credit limit',
          style: baseTextStyle16500,
        ),
        const Gap(8),
        Text(
          'First step is to check your credit limit.',
          style: baseTextStyle12400,
        ),
        const Gap(8),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFAEC),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 4, bottom: 4),
                child: Text(
                  '45% for equity funds ',
                  style: baseTextStyle12400.copyWith(
                      color: const Color(0xFF727579)),
                ),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFAEC),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 4, bottom: 4),
                child: Text(
                  '75% for debt funds  ',
                  style: baseTextStyle12400.copyWith(
                      color: const Color(0xFF727579)),
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        Text(
          'No impact on your CIBIL score.',
          style: baseTextStyle12400,
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apply for a loan',
          style: baseTextStyle16500,
        ),
        const Gap(8),
        RichText(
          text: TextSpan(
            style: baseTextStyle12400.copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(text: '• Click on '),
              TextSpan(
                text: '“Avail Loan”',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Gap(5),
        RichText(
          text: TextSpan(
            style: baseTextStyle12400.copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(text: '• '),
              TextSpan(
                text: 'Import',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' your holdings'),
            ],
          ),
        ),
        const Gap(5),
        RichText(
          text: TextSpan(
            style: baseTextStyle12400.copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(text: '• Provide '),
              TextSpan(
                text: 'PAN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' details, '),
              TextSpan(
                text: 'bank',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' information'),
            ],
          ),
        ),
        const Gap(5),
        RichText(
          text: TextSpan(
            style: baseTextStyle12400.copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(text: '• '),
              TextSpan(
                text: 'Pledge',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' your holdings'),
            ],
          ),
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan agreement',
          style: baseTextStyle16500,
        ),
        const Gap(8),
        RichText(
          text: TextSpan(
            style: baseTextStyle12400.copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(
                  text:
                      'Before you get your cash is credited, you need to sign '),
              TextSpan(
                text: 'a loan agreement',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan availed',
          style: baseTextStyle16500,
        ),
        const Gap(8),
        RichText(
          text: TextSpan(
            style: baseTextStyle12400.copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(text: 'In '),
              TextSpan(
                text: '2 hours',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ', cash will be credited to your bank account'),
            ],
          ),
        ),
        const Gap(8),
        RichText(
          text: TextSpan(
            style: baseTextStyle12400.copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(text: 'Interest is '),
              TextSpan(
                text: 'auto-debited',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' monthly'),
            ],
          ),
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSliderVisible = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFBEDCFF)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isSliderVisible ? _buildSlider() : _buildInitialContent(),
        ),
      ),
    );
  }

  Widget _buildInitialContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Not sure how it works?', style: baseTextStyle16500),
            const Gap(5),
            Text('Learn more  >',
                style: baseTextStyle12400.copyWith(
                    color: const Color(0xFF2E8EFF))),
          ],
        ),
        Image.asset(Assets.pngs.howItWorks.path.toString(),
            height: 51, width: 51),
      ],
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      height: 150, // Set a height for the slider
      child: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          final actualIndex = index % 5;
          return _buildSliderPage(actualIndex);
        },
      ),
    );
  }

  Widget _buildSliderPage(var index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listHIW[index],
        Center(
          child: Text(
            '< ${index + 1}/5 >',
            style: baseTextStyle10400.copyWith(color: const Color(0xFFBEBFC1)),
          ),
        )
      ],
    );
  }
}
