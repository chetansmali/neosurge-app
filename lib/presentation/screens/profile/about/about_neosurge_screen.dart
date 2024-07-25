import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';
import '../../mpin/login_mpin_background.dart';

class AboutNeosurgeScreen extends StatelessWidget {
  const AboutNeosurgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      color: AppColors.neutral[400]!,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('About Us', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Gap(24.0),
              Assets.appIcons.splashLogo.image(width: 180.0),
              const Gap(24.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black26,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text('ABOUT NEOSURGE',
                    style: baseTextStyle10600.copyWith(color: Colors.white)),
              ),
              const Gap(12.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Neosurge is a Wealth Management Companion designed to '
                          'be both simple and personalised, providing data-driven '
                          'insights, timely reminders, and actionable notifications.\n\n',
                      style: baseTextStyle14600.copyWith(color: Colors.white),
                    ),
                    const TextSpan(
                      text:
                          'This tool enables you to invest and manage your wealth '
                          'confidently without depending on others. It assists you '
                          'in making informed decisions and overcoming barriers to '
                          'good financial behaviour, thereby fostering fiscal prudence.',
                    ),
                  ],
                  style: baseTextStyle14400.copyWith(color: Colors.white),
                ),
              ),
              const Gap(12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black26,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text('ABOUT THE TEAM',
                    style: baseTextStyle10600.copyWith(color: Colors.white)),
              ),
              const Gap(12.0),
              RichText(
                  text: TextSpan(
                children: const [
                  TextSpan(
                    text: 'Avinash, a tech veteran, has spent over a decade '
                        'working with global tech giants and banks like HSBC '
                        'and Lloyds on large-scale distributed systems and '
                        'FinTech solutions.\n\n',
                  ),
                  TextSpan(
                      text:
                          'Biswajit, an ex-banker turned entrepreneur, boasts a '
                          'decade of financial advisory and wealth management '
                          'experience, handling assets exceeding INR 750 crore '
                          'and serving over 7000 clients.\n\n'),
                  TextSpan(
                      text:
                          'We are a formidable team comprised of visionary CTO, '
                          'creative designers, skilled engineers, experienced '
                          'product managers, knowledgeable wealth managers, insightful '
                          'analysts, trusted partners, and a well-connected industry network.\n\n'),
                ],
                style: baseTextStyle14400.copyWith(color: Colors.white),
              )),
              const Gap(24.0),
            ],
          ),
        ),
      ),
    );
  }
}
