import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';

import '../../data/enums/day_usage_enum.dart';
import '../../data/models/day.dart';
import '../../main.dart';
import '../../states/screens/create_screen/create_day_states.dart';
import '../../utils/jiff.dart';
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
            style: Theme.of(context).textTheme.headline6!.apply(
                  fontWeightDelta: 1,
                  fontSizeDelta: -1,
                ),
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
              icon: Ionicons.add_outline,
              text: 'Add',
              onPressed: () {
                // Todo validation

                final Jiff dayFrom = Jiff(day.from);
                final Jiff dayTo = Jiff(day.to);
                final int weeks = dayTo.week - dayFrom.week;

                for (int i = 0; i <= weeks; i++) {
                  Jiff from = Jiff(dayFrom.dateTime).add(weeks: i);
                  Jiff to = Jiff(dayTo.dateTime);

                  // Not the last of many weeks
                  if (i == 0 && weeks > 0) {
                    to = Jiff(from.dateTime).endOf(Units.WEEK);
                  }
                  // Not the first of many weeks
                  if (i == weeks && weeks > 0) {
                    from = Jiff(to.dateTime).startOf(Units.WEEK);
                  }

                  final Day tmpDay = Day(
                    from: from.dateTime,
                    to: to.dateTime,
                    usage: day.usage,
                    multiplier: day.multiplier,
                    comment: day.comment,
                  );
                  if (day.breaks.isEmpty) {
                    tmpDay.breaks.removeWhere((_) => true);
                  } else {
                    // Todo split breaks if necessary
                    tmpDay.breaks.addAll(day.breaks);
                  }
                  db.store.box<Day>().put(tmpDay);
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
