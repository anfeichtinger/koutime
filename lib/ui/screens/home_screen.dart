import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../config/router.dart';
import '../../data/models/day.dart';
import '../../main.dart';
import '../../objectbox.g.dart';
import '../../states/screens/home_screen/month_state.dart';
import '../widgets/bottom_application_bar.dart';
import '../widgets/extended_fab.dart';
import '../widgets/home_screen/app_bar_home.dart';
import '../widgets/home_screen/home_entry.dart';
import '../widgets/home_screen/month_strip.dart';
import 'create_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const int dragSensitivity = 6;
  static GlobalKey<MonthStripState> monthStripKey =
      GlobalKey<MonthStripState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime selectedStart = ref.watch(monthProvider).start;
    final DateTime selectedEnd = ref.watch(monthProvider).end;

    return Scaffold(
      appBar: const AppBarHome(),
      bottomNavigationBar: const BottomApplicationBar(),
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
            monthStripKey.currentState!.controller.animateToPage(
                (monthStripKey.currentState!.controller.page! - 1).toInt(),
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease);
          } else if (details.primaryVelocity! < -dragSensitivity) {
            monthStripKey.currentState!.controller.animateToPage(
                (monthStripKey.currentState!.controller.page! + 1).toInt(),
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease);
          }
        },
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: <Widget>[
              MonthStrip(
                key: monthStripKey,
                physics: const BouncingScrollPhysics(),
                from: DateTime(2020),
                to: DateTime.now().add(const Duration(days: 365)),
                initialMonth: selectedStart,
                onMonthChanged: (DateTime month) {
                  ref.read(monthProvider.notifier).start =
                      DateTime(month.year, month.month);
                  ref.read(monthProvider.notifier).end =
                      DateTime(month.year, month.month + 1, 0, 23, 59, 59);
                },
              ),
              const SizedBox(height: 8),
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
