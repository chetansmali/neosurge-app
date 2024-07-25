import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/get_it.dart';
import '../../../cubits/mutual_funds/report/report_cubit.dart';
import '../../../theme/app_colors.dart';
import 'report_button.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTileTheme(
          data: const ExpansionTileThemeData(
            textColor: AppColors.mainBlack,
            childrenPadding: EdgeInsets.all(8),
            collapsedIconColor: AppColors.mainBlack,
            collapsedTextColor: AppColors.mainBlack,
            backgroundColor: Colors.white,
            expandedAlignment: Alignment.bottomRight,
            iconColor: AppColors.mainBlack,
            tilePadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Mutual Funds',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColors.lightGrey,
                  ),
                  BlocProvider(
                    create: (context) => getIt<ReportCubit>(),
                    child: const ReportButton(),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
