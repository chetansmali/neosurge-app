import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../common/common.dart';
import '../../../gen/assets.gen.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';

class GoalPlanningOnboardScreen extends StatelessWidget {
  const GoalPlanningOnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  widthFactor: 0.6,
                  child: _CustomCard(
                      icon:
                          Assets.pngs.goalMarriage.image(height: 48, width: 48),
                      title: 'Dream Wedding',
                      bgColor: Colors.green),
                ),
                _CustomCard(
                    icon: Assets.pngs.goalHome.image(height: 48, width: 48),
                    title: 'Own a home',
                    bgColor: Colors.red),
                Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.2,
                    child: _CustomCard(
                        icon: Assets.pngs.goalVehical
                            .image(height: 48, width: 48),
                        title: 'Buy a car',
                        bgColor: Colors.blueAccent)),
              ],
            ),
            const Gap(22),
            Row(
              children: [
                const Gap(10),
                _CustomCard(
                    icon:
                        Assets.pngs.goalRetirement.image(height: 48, width: 48),
                    title: 'Retirement',
                    bgColor: Colors.blueGrey),
                _CustomCard(
                    icon:
                        Assets.pngs.goalEducation.image(height: 48, width: 48),
                    title: 'Child’s education',
                    bgColor: Colors.orangeAccent),
                Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.1,
                  child: _CustomCard(
                      icon: Assets.pngs.goalRetirement
                          .image(height: 48, width: 48),
                      title: 'Retirement',
                      bgColor: Colors.yellow),
                ),
              ],
            ),
            const Gap(46),
            Text(
              'Turn your dreams into reality',
              style: baseTextStyle32500.copyWith(fontWeight: FontWeight.w600),
            ),
            const Gap(12),
            Text(
              'Create your first goal on your journey to financial freedom',
              style: baseTextStyle14500.copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.goalChoiceScreen);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                maximumSize: const Size.fromHeight(50),
              ),
              child: Text(
                'Get started',
                style: baseTextStyle16500.copyWith(color: Colors.white),
              )),
        ),
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard(
      {required this.title, required this.bgColor, required this.icon});

  final String title;
  final Color bgColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 135,
        height: 130,
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const Gap(12),
            SizedBox(
              width: 80,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: baseTextStyle12400,
              ),
            ),
          ],
        ));
  }
}
