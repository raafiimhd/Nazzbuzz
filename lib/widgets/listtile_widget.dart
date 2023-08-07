import 'package:flutter/material.dart';

class Listtile extends StatelessWidget {
  final int index;
  final BuildContext context;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing1;
  final Widget? trailing2;

  Listtile( {
    required this.index,
    required this. context,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing1,
    this.trailing2,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing1 != null) trailing1!,
          if (trailing2 != null) trailing2!,
        ],
      ),
    );
  }
}
