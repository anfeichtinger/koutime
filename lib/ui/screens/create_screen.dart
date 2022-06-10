import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../data/enums/day_usage_enum.dart';
import '../../states/screens/create_screen/create_day_states.dart';
import '../widgets/app_bar_base.dart';
import '../widgets/bottom_application_bar.dart';
import '../widgets/create_screen/create_free.dart';
import '../widgets/create_screen/create_shift.dart';
import '../widgets/create_screen/create_sick.dart';
import '../widgets/create_screen/type_tabs.dart';
import '../widgets/extended_fab.dart';

class CreateScreen extends ConsumerWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    final DayUsage currentUsage = ref.watch(createDayProvider).day.usage;
    return Scaffold(
      appBar: AppBarBase(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            tr('Add appointment'),
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
      floatingActionButton: showFab
          ? ExtendedFab(
              icon: Ionicons.save_outline,
              text: 'Save',
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: 24),
              const TypeTabs(),
              const SizedBox(height: 16),
              getPartialBasedOnUsage(currentUsage),
              const SizedBox(height: 48),
            ]),
      ),
    );
  }

  Widget getPartialBasedOnUsage(DayUsage usage) {
    switch (usage) {
      case DayUsage.free:
        return const CreateFree();
      case DayUsage.sick:
        return const CreateSick();
      case DayUsage.holiday:
      case DayUsage.shift:
        return const CreateShift();
    }
  }
}
