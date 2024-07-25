import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../theme/app_colors.dart';

class FeatureBanner extends StatelessWidget {
  final String title;
  final List<String> blueTexts;

  const FeatureBanner(
      {super.key, required this.title, required this.blueTexts});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.4),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(child: _buildRichText()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRichText() {
    List<TextSpan> spans = [];
    String remainingText = title;

    while (remainingText.isNotEmpty) {
      bool matched = false;

      for (String blueText in blueTexts) {
        if (remainingText.startsWith(blueText)) {
          spans.add(TextSpan(
            text: blueText,
            style: const TextStyle(color: Color(0xFF2E8EFF)),
          ));
          remainingText = remainingText.substring(blueText.length);
          matched = true;
          break;
        }
      }

      if (!matched) {
        int nextMatchIndex = remainingText.length;
        for (String blueText in blueTexts) {
          int index = remainingText.indexOf(blueText);
          if (index != -1 && index < nextMatchIndex) {
            nextMatchIndex = index;
          }
        }

        spans.add(TextSpan(text: remainingText.substring(0, nextMatchIndex)));
        remainingText = remainingText.substring(nextMatchIndex);
      }
    }

    return RichText(
      text: TextSpan(
        style: baseTextStyle12400.copyWith(color: Colors.black),
        children: spans,
      ),
    );
  }
}
