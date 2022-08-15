import 'package:flutter/material.dart';

class CardRounded extends StatelessWidget {
  const CardRounded({
    super.key,
    this.child,
    this.children,
    this.subtitle,
    this.leadingIcon,
    this.leading,
    this.trailing,
    this.onPress,
    this.onLongPress,
    this.isThreeLine = false,
    this.contentPadding,
    this.margin,
  })  : assert((child == null && children != null) ||
            (child != null && children == null)),
        assert((leading != null && leadingIcon == null) ||
            (leading == null && leadingIcon != null) ||
            (leading == null && leadingIcon == null));
  final Widget? child;
  final Widget? subtitle;
  final Function()? onPress;
  final Function()? onLongPress;
  final List<Widget>? children;
  final IconData? leadingIcon;
  final Widget? leading;
  final Widget? trailing;
  final bool isThreeLine;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;

  Widget? _getLeading(BuildContext context) {
    if (leadingIcon != null) {
      return Center(
        widthFactor: 1,
        child: Icon(leadingIcon,
            color: Theme.of(context).textTheme.bodySmall!.color),
      );
    }

    if (leading != null) {
      return leading!;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Theme.of(context).colorScheme.shadow,
      margin: margin,
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: child != null
          ? InkWell(
              onTap: onPress,
              onLongPress: onLongPress,
              splashColor: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: ListTile(
                leading: _getLeading(context),
                title: child,
                subtitle: subtitle,
                trailing: Center(widthFactor: 1, child: trailing),
                isThreeLine: isThreeLine,
                contentPadding: contentPadding,
              ),
            )
          : Padding(
              padding: contentPadding ?? EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children!,
              ),
            ),
    );
  }
}
