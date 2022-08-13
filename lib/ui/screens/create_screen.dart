import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../data/enums/day_usage_enum.dart';
import '../../data/models/day.dart';
import '../../main.dart';
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
    final Day day = ref.watch(createDayProvider).day;
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
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.background,
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
              color: Theme.of(context).textTheme.bodyMedium!.color,
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
                // Todo validation
                switch (day.usage) {
                  case DayUsage.holiday:
                  case DayUsage.free:
                  case DayUsage.sick:
                    day.from =
                        DateTime(day.from.year, day.from.month, day.from.day);
                    day.to = DateTime(
                        day.to.year, day.to.month, day.to.day, 23, 59, 59);
                    day.breaks.removeWhere((_) => true);
                    day.multiplier = 1;
                    db.store.box<Day>().put(day);
                    break;
                  case DayUsage.shift:
                    // Todo create shift
                    break;
                }
                Navigator.of(context).pop(day);
              },
            )
          : null,
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 16.sp),
              const TypeTabs(),
              SizedBox(height: 16.sp),
              getPartialBasedOnUsage(day.usage),
              SizedBox(height: 48.sp),
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
