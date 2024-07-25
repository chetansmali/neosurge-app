import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../theme/app_colors.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title, description;

  const CustomExpansionTile(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEAF4FF)),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                splashColor: Colors.transparent,
                title: Text(
                  widget.title,
                  style: baseTextStyle14400,
                ),
                onTap: _toggleExpanded,
                trailing: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: const Color(0xFF2E8EFF),
                ),
              ),
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Text(
                    widget.description,
                    style:
                        baseTextStyle12400.copyWith(color: AppColors.textGrey),
                  ),
                ),
                firstCurve: Curves.fastOutSlowIn,
                secondCurve: Curves.fastOutSlowIn,
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
