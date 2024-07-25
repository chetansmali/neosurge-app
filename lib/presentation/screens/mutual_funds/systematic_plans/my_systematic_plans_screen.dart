import 'package:flutter/material.dart';

import 'active_plans_tabview.dart';
import 'inactive_plans_tabview.dart';

class MySystematicPlanScreen extends StatelessWidget {
  const MySystematicPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Systematic Plans'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Active Plans',
              ),
              Tab(
                text: 'Cancelled Plans',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ActivePlansTabView(),
            InactivePlansTabView(),
          ],
        ),
      ),
    );
  }
}
