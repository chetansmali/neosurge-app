import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';

class EquityNotification extends StatefulWidget {
  const EquityNotification({super.key});

  @override
  State<EquityNotification> createState() => _EquityNotificationState();
}

class _EquityNotificationState extends State<EquityNotification> {
  final bool _isNewNoti = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Gap(32),
                Expanded(
                  child: SearchBar(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(10, 0, 10, 0)),
                    hintText: 'Search companies',
                    leading: Assets.icons.magniferHome.svg(),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(child: Assets.icons.notificationHome.svg()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () => Navigator.pushNamed(context, Routes.profile),
                      child: Assets.icons.appBarProfile.svg()),
                ),
              ],
            ),
            const Gap(12),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Today'),
            ),
            const Gap(12),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: _isNewNoti ? Colors.white : Colors.blue[50],
                      ),
                      child: ListTile(
                        title: const Text('CANBANK @ rs 380'),
                        subtitle: RichText(
                          text: const TextSpan(
                              text: ' ',
                              style: TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                  text: 'Buy ',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(text: ' order of'),
                                TextSpan(
                                  text: ' 45 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                TextSpan(
                                    text:
                                        ' order ofshares has been confirmed. Transaction will reflect in '),
                                TextSpan(
                                    text: ' 2-3 ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                TextSpan(
                                  text: ' business days.',
                                ),
                              ]),
                        ),
                        trailing: const Text('17h 30m'),
                        leading: Assets.svgs.equityNotification.svg(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
