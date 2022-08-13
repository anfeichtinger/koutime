import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../config/router.dart';
import '../../data/models/day.dart';
import '../../main.dart';
import '../../objectbox.g.dart';
import '../../states/screens/home_screen/week_state.dart';
import '../../utils/jiff.dart';
import '../widgets/bottom_application_bar.dart';
import '../widgets/extended_fab.dart';
import '../widgets/home_screen/app_bar_home.dart';
import '../widgets/home_screen/home_entry.dart';
import '../widgets/home_screen/week_strip.dart';
import 'create_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const int dragSensitivity = 6;
  static GlobalKey<WeekStripState> weekStripKey = GlobalKey<WeekStripState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime selectedStart = ref.watch(weekProvider).start;
    final DateTime selectedEnd = ref.watch(weekProvider).end;

    print(selectedStart);
    print(selectedEnd);

    return Scaffold(
      appBar: const AppBarHome(),
      bottomNavigationBar: const BottomApplicationBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ExtendedFab(
        icon: Ionicons.add_outline,
        text: 'Add',
        onPressed: () {
          Navigator.of(context).push(createRoute(const CreateScreen()));
        },
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > dragSensitivity) {
            weekStripKey.currentState!.controller.animateToPage(
                (weekStripKey.currentState!.controller.page! - 1).toInt(),
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease);
          } else if (details.primaryVelocity! < -dragSensitivity) {
            weekStripKey.currentState!.controller.animateToPage(
                (weekStripKey.currentState!.controller.page! + 1).toInt(),
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease);
          }
        },
        child: Material(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: <Widget>[
              SizedBox(height: 4.sp),
              WeekStrip(
                key: weekStripKey,
                physics: const BouncingScrollPhysics(),
                fromYear: 2022,
                toYear: Jiff().add(years: 1).year,
                onWeekChanged: (DateTime week) {
                  ref.read(weekProvider.notifier).setWeek(week);
                },
              ),
              SizedBox(height: 8.sp),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  physics: const BouncingScrollPhysics(),
                  children: (db.store.box<Day>().query(Day_.from
                          .between(selectedStart.millisecondsSinceEpoch,
                              selectedEnd.millisecondsSinceEpoch)
                          .and(Day_.to.between(
                              selectedStart.millisecondsSinceEpoch,
                              selectedEnd.millisecondsSinceEpoch)))
                        ..order(Day_.from))
                      .build()
                      .find()
                      .map((Day day) => HomeEntry(day: day))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
