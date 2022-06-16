import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/router.dart';
import 'config/theme.dart';
import 'data/repository/object_box.dart';
import 'states/theme_mode_state.dart';

/// Provides access to the ObjectBox Store throughout the app
late ObjectBox db;

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();

  /// Create db
  db = await ObjectBox.create();

  /// Init Hive
  await Hive.initFlutter();
  await Hive.openBox('prefs');

  /// Init localization
  await EasyLocalization.ensureInitialized();

  /// Init refresh rate
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('de'),
        ],
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,

        /// Try using const constructors as much as possible!
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState currentTheme = ref.watch(themeProvider);

    return ScreenUtilInit(
        // designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            /// Localization is not available for the title.
            title: 'Koutime',

            /// Theme stuff
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: currentTheme.themeMode,

            /// Localization stuff
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            /// Route stuff
            routes: routes,
            initialRoute: '/',

            /// Misc
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
