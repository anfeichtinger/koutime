import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../config/router.dart';
import '../widgets/bottom_application_bar.dart';
import '../widgets/extended_fab.dart';
import '../widgets/home_screen/app_bar_home.dart';
import 'create_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarHome(),
      bottomNavigationBar: const BottomApplicationBar(
          // leftWidgets: <Widget>[
          //   IconButton(
          //     onPressed: () => <void>{},
          //     splashRadius: 24,
          //     tooltip: tr('Archive'),
          //     icon: Icon(
          //       Ionicons.archive_outline,
          //       color: Theme.of(context).textTheme.bodyText2!.color,
          //     ),
          //   ),
          //   const SizedBox(width: 12),
          //   IconButton(
          //     onPressed: () => <void>{},
          //     splashRadius: 24,
          //     tooltip: tr('Export'),
          //     icon: Icon(
          //       Ionicons.share_outline,
          //       color: Theme.of(context).textTheme.bodyText2!.color,
          //     ),
          //   ),
          // ],
          // rightWidgets: [
          //   IconButton(
          //     onPressed: () => <void>{},
          //     splashRadius: 24,
          //     tooltip: tr('Holiday'),
          //     icon: Icon(
          //       Ionicons.airplane_outline,
          //       color: Theme.of(context).textTheme.bodyText2!.color,
          //     ),
          //   ),
          //   const SizedBox(width: 12),
          //   IconButton(
          //     onPressed: () => <void>{},
          //     splashRadius: 24,
          //     tooltip: tr('Call in sick'),
          //     icon: Icon(
          //       Ionicons.medkit_outline,
          //       color: Theme.of(context).textTheme.bodyText2!.color,
          //     ),
          //   ),
          // ],
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ExtendedFab(
        icon: Ionicons.add_outline,
        text: 'Add',
        onPressed: () {
          Navigator.of(context).push(createRoute(const CreateScreen()));
        },
      ),
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics()),
      ),
    );
  }
}
