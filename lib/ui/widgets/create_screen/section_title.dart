import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {super.key,
      required this.padding,
      this.icon,
      required this.text,
      this.trailing});

  final EdgeInsets padding;
  final IconData? icon;
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (icon != null)
            Icon(
              icon,
              size: 16,
              color: Theme.of(context).textTheme.caption!.color,
            )
          else
            const SizedBox(),
          const SizedBox(width: 4),
          Text(
            tr(text),
            style:
                Theme.of(context).textTheme.caption!.apply(fontWeightDelta: 2),
          ),
          const Spacer(),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
