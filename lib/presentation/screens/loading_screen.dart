import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/util_cubits/loading_cubit.dart';
import '../widgets/custom_loader.dart';

class LoadingScreen extends StatelessWidget {
  final Widget child;

  const LoadingScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
      builder: (context, shouldShow) {
        return WillPopScope(
          onWillPop: () async => !shouldShow,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              child,
              if (shouldShow) ...[
                Container(
                  color: Colors.grey.withOpacity(0.4),
                  child: const Center(
                    child: CustomLoader(),
                  ),
                ),
                // Stack(
                //   fit: StackFit.loose,
                //   alignment: Alignment.center,
                //   children: [
                //     Material(
                //       elevation: 20,
                //       shadowColor: AppColors.secondaryBlue,
                //       borderRadius: BorderRadius.circular(20),
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         height: 150,
                //         width: 150,
                //         child: const Center(child: CustomLoader()),
                //       ),
                //     )
                //   ],
                // )
              ]
            ],
          ),
        );
      },
    );
  }
}
