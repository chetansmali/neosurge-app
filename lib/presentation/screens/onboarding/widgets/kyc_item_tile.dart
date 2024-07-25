import 'package:flutter/material.dart';

class KycItemTile extends StatelessWidget {
  const KycItemTile({
    super.key,
    required this.leading,
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  final Widget leading;
  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: ListTile(
          leading: leading,
          title: Text(title),
          trailing: trailing,
        ),
      ),
    );
  }
}
