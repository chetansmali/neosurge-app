import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/custom_styles.dart';
import '../../../../common/utils.dart';
import '../../../../domain/entities/params/neobaskets/delete_sip_params.dart';
import '../../../cubits/neobaskets/delete_sip/delete_sip_cubit.dart';

class DeleteConfirmationSIPDialog extends StatelessWidget {
  const DeleteConfirmationSIPDialog({
    super.key,
    required this.sipOrderRef,
  });

  final String sipOrderRef;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Delete current SIP?',
                    style: baseTextStyle16500.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<DeleteSipCubit, DeleteSipState>(
                      listener: (context, state) {
                    if (state is DeleteSipSuccess) {
                      Navigator.pop(context, true);
                      Utils.showSuccessAlert(
                        context,
                        'SIP deleted Successfully. It will be reflected in your portfolio shortly.',
                      );
                    }
                  }, builder: (context, state) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF0FE),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: Text(
                                  'No',
                                  style: baseTextStyle16500.copyWith(
                                    color: const Color(0xFF297DFD),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            context.read<DeleteSipCubit>().deleteSip(
                                  DeleteSipParams(
                                    sipOrderRef: sipOrderRef,
                                  ),
                                );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAEBEB),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: Text(
                                  'Yes',
                                  style: baseTextStyle16500.copyWith(
                                      color: const Color(0xFFFB4F39)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
