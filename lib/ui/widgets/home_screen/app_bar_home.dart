import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

import '../../../config/router.dart';
import '../../../config/theme.dart';
import '../../../data/enums/animation_direction.dart';
import '../../screens/settings_screen.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

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
        backgroundColor: Theme.of(context).cardColor,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            tr('app_name'),
            style: Theme.of(context).textTheme.headline5!.copyWith(
                fontFamily: 'Pacifico',
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: <Color>[
                      primarySwatch.shade500,
                      primarySwatch.shade300,
                      //add more color here.
                    ],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () => <void>{
                Navigator.of(context).push(createRoute(const SettingsScreen(),
                    direction: AnimationDirection.rightToLeft))
              },
              tooltip: tr('Settings'),
              splashRadius: 28,
              icon: Icon(
                Ionicons.settings_outline,
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
