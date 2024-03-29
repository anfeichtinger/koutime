import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 36),
      child: Text(
        tr(text),
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(fontWeightDelta: 2),
      ),
    );
  }
}
