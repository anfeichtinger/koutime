import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

import '../../../config/router.dart';
import '../../../config/theme.dart';
import '../../../data/enums/animation_direction.dart';
import '../../../data/models/day.dart';
import '../../../main.dart';
import '../../screens/settings_screen.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).colorScheme.brightness;

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Hero(
        tag: 'application_bar',
        placeholderBuilder: (BuildContext context, Size size, Widget widget) {
          return Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          );
        },
        child: AppBar(
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          toolbarHeight: 64,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).colorScheme.surfaceVariant,
              statusBarIconBrightness: brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          elevation: 3,
          shadowColor: Theme.of(context).colorScheme.shadow,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              tr('app_name'),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontFamily: 'Pacifico',
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[
                        primarySwatch.shade500,
                        primarySwatch.shade300,
                        //add more color here.
                      ],
                    ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => db.store.box<Day>().removeAll(),
              tooltip: tr('Delete all days'),
              splashRadius: 28,
              icon: Icon(
                Ionicons.trash_outline,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
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
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
