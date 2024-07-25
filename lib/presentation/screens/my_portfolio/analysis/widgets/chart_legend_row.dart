import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChartLegendRow extends StatelessWidget {
  const ChartLegendRow({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.color,
    required this.title,
    required this.percentage,
  });

  final int index;
  final int selectedIndex;
  final Color color;
  final String title;
  final String percentage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: selectedIndex == -1
                  ? color
                  : index == selectedIndex
                      ? color
                      : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: selectedIndex == -1
                  ? const Color(0xFF47586E)
                  : index == selectedIndex
                      ? const Color(0xFF47586E)
                      : const Color(0xFF47586E).withOpacity(0.25),
            ),
          ),
          const Spacer(),
          Text(
            percentage,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: selectedIndex == -1
                  ? const Color(0xFF47586E)
                  : index == selectedIndex
                      ? const Color(0xFF47586E)
                      : const Color(0xFF47586E).withOpacity(0.25),
            ),
          ),
        ],
      ),
    );
  }
}
