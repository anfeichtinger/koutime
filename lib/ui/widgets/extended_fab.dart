import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class ExtendedFab extends StatelessWidget {
  const ExtendedFab(
      {super.key,
      required this.text,
      this.icon,
      this.onPressed,
      this.animate = true});

  final String text;
  final IconData? icon;
  final OnPressed? onPressed;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        elevation: 3,
        highlightElevation: 6,
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          tr(text),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
        onPressed: onPressed);
  }
}
