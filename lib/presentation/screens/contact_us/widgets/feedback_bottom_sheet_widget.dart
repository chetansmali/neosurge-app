import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/contact_us/capture_faq_dislike_cubit/capture_faq_dislike_cubit.dart';
import '../../../cubits/contact_us/get_dislike_reasons/get_dislike_reasons_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import 'feeback_item_widget.dart';

class FeedBackBottomSheet extends StatefulWidget {
  final String faqId;
  const FeedBackBottomSheet({super.key, required this.faqId});

  @override
  State<FeedBackBottomSheet> createState() => _FeedBackBottomSheetState();
}

class _FeedBackBottomSheetState extends State<FeedBackBottomSheet> {
  late final TextEditingController _messagecontroller;
  bool feedbacksubmitted = false;

  @override
  void initState() {
    _messagecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CaptureFaqDislikeCubit, CaptureFaqDislikeState>(
      listener: (context, submissionState) {
        if (submissionState is CaptureFaqDislikeSuccess) {
          _messagecontroller.clear();
          setState(() {
            feedbacksubmitted = true;
          });
        }
        if (submissionState is CaptureFaqDislikeStateFailure) {
          Utils.showErrorAlert(
            context,
            submissionState.errorMessage.toString(),
          );
        }
      },
      builder: (context, submissionState) {
        return BlocBuilder<GetDislikeReasonsCubit, GetDislikeReasonsState>(
          builder: (context, state) {
            if (state is GetDislikeReasonsLoading) {
              return const CustomLoader();
            }
            if (state is GetDislikeReasonsLoadError) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
              );
            }
            if (state is GetDislikeReasonsLoaded) {
              if (submissionState is CaptureFaqDislikeInitial) {
                return SizedBox(
                  height: 408,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Tell us what went wrong"),
                        subtitle: const Text("Your feeback matters to us"),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 0.0,
                        children: List.generate(
                          state.getDislikereasonslist.length,
                          (index) => FeebackItemsWidget(
                            feebacktext: state.getDislikereasonslist[index],
                            isSelected: state.selectedReasons.contains(
                              state.getDislikereasonslist[index],
                            ),
                            onTap: () {
                              context
                                  .read<GetDislikeReasonsCubit>()
                                  .toggleSelection(
                                    state.getDislikereasonslist[index],
                                  );
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 96,
                        margin: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: _messagecontroller,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: 'Add your message here (Optional)',
                            hintStyle: const TextStyle(fontSize: 12),
                            fillColor: Colors.white,
                            focusColor: AppColors.primary[500],
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.neutral[200] ?? Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.neutral[200] ?? Colors.white,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.neutral[200] ?? Colors.white,
                              ),
                            ),
                            filled: true,
                          ),
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      // const Gap(44),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CaptureFaqDislikeCubit>().submitFeeback(
                                faqId: widget.faqId,
                                dislikeReason: state.selectedReasons.toString(),
                                message: _messagecontroller.text,
                              );
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                );
              }
              if (submissionState is CaptureFaqDislikeLoading) {
                return const SizedBox();
              }
              if (submissionState is CaptureFaqDislikeSuccess) {
                return SizedBox(
                  height: 458,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Tell us what went wrong"),
                        subtitle: const Text("Your feeback matters to us"),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                      Assets.pngs.customerFeebackSuccess.image(
                        width: 240,
                        height: 240,
                      ),
                      const Text("Your feeback has been submitted."),
                      const Text(
                        "Thank you!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
