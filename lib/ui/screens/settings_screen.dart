import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/app_bar_base.dart';
import '../widgets/bottom_application_bar.dart';
import '../widgets/extended_fab.dart';
import '../widgets/settings_screen/theme_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            tr('Settings'),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(fontWeightDelta: 1, fontSizeDelta: -1),
          ),
        ),
      ),
      bottomNavigationBar: BottomApplicationBar(
        leftWidgets: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            splashRadius: 24,
            tooltip: tr('Back'),
            icon: Icon(
              Ionicons.arrow_back_outline,
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ExtendedFab(
        icon: Ionicons.star_outline,
        text: 'Rate',
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: 24),
              Card(
                elevation: 0,

                /// Example: Many items have their own colors inside of the ThemData
                /// You can overwrite them in [config/theme.dart].
                color: Theme.of(context).cardColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: SwitchListTile(
                  onChanged: (bool newValue) {
                    /// Example: Change locale
                    /// The initial locale is automatically determined by the library.
                    /// Changing the locale like this will persist the selected locale.
                    context.setLocale(
                        newValue ? const Locale('de') : const Locale('en'));
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  value: context.locale == const Locale('de'),
                  title: Row(
                    children: <Widget>[
                      Icon(Ionicons.text_outline,
                          color: Theme.of(context).primaryColor),
                      const SizedBox(width: 16),
                      Text(
                        tr('language_switch_title'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.75 / 1,
                  children: const <ThemeCard>[
                    ThemeCard(
                      mode: ThemeMode.system,
                      icon: Ionicons.contrast_outline,
                    ),
                    ThemeCard(
                      mode: ThemeMode.light,
                      icon: Ionicons.sunny_outline,
                    ),
                    ThemeCard(
                      mode: ThemeMode.dark,
                      icon: Ionicons.moon_outline,
                    ),
                  ]),
            ]),
      ),
    );
  }
}
