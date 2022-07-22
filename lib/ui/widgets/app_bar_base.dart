import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBase({super.key, required this.title, this.actions});

  final Widget title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;

    return Hero(
      tag: 'application_bar',
      placeholderBuilder: (BuildContext context, Size size, Widget widget) {
        return Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
        );
      },
      child: AppBar(
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        toolbarHeight: 64,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        elevation: 0,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
