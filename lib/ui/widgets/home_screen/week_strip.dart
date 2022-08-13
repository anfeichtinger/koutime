/*
* Credits go to: mahmed8003
* Git Repository: https://github.com/mahmed8003/month_picker_strip
*/

library month_strip;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';

import '../../../utils/jiff.dart';

const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class WeekStrip extends StatefulWidget {
  const WeekStrip({
    super.key,
    required this.fromYear,
    required this.toYear,
    required this.onWeekChanged,
    this.physics,
    this.height = 48.0,
    this.viewportFraction = 0.45,
  });

  final int fromYear;
  final int toYear;
  final ValueChanged<DateTime> onWeekChanged;
  final double height;
  final double viewportFraction;

  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  @override
  // ignore: no_logic_in_create_state
  WeekStripState createState() {
    final Jiff from = Jiff(<int>[fromYear]);

    final List<WeekItem> weeks = <WeekItem>[];
    int initialPage = 0;

    from.startOf(Units.WEEK);

    while (from.year < toYear) {
      final WeekItem item = WeekItem(from.dateTime);
      if (from.week == Jiff().week) {
        item.selected = true;
        initialPage = weeks.length;
      }
      weeks.add(item);
      from.add(weeks: 1);
    }

    return WeekStripState(
        viewportFraction: viewportFraction,
        initialPage: initialPage,
        weeks: weeks);
  }
}

class WeekStripState extends State<WeekStrip> {
  WeekStripState(
      {required double viewportFraction,
      required int initialPage,
      required this.weeks})
      : controller = PageController(
            viewportFraction: viewportFraction, initialPage: initialPage),
        _lastReportedPage = initialPage;
  final List<WeekItem> weeks;
  final PageController controller;
  int _lastReportedPage;

  @override
  Widget build(BuildContext context) {
    const AxisDirection axisDirection = AxisDirection.right;
    final ScrollPhysics physics = _kPagePhysics.applyTo(widget.physics);
    return SizedBox(
      height: widget.height,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (ScrollEndNotification notification) {
          if (notification.depth == 0) {
            final PageMetrics metrics = notification.metrics as PageMetrics;
            final int currentPage = metrics.page!.round();
            if (currentPage != _lastReportedPage) {
              _lastReportedPage = currentPage;

              setState(() {
                for (final WeekItem item in weeks) {
                  item.selected = false;
                }
                final WeekItem m = weeks[currentPage];
                final DateTime d = m.time;
                m.selected = true;
                widget.onWeekChanged(DateTime(d.year, d.month, d.day));
              });
            }
          }
          return false;
        },
        child: Scrollable(
          axisDirection: axisDirection,
          controller: controller,
          physics: physics,
          viewportBuilder: (BuildContext context, ViewportOffset position) {
            return Viewport(
              axisDirection: axisDirection,
              offset: position,
              slivers: <Widget>[
                SliverFillViewport(
                  viewportFraction: controller.viewportFraction,
                  delegate: SliverChildBuilderDelegate(_buildContent,
                      childCount: weeks.length),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int index) {
    final WeekItem item = weeks[index];
    return AnimatedContainer(
      margin: item.selected ? EdgeInsets.all(6.sp) : EdgeInsets.all(8.sp),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(99)),
        color: item.selected
            ? Theme.of(context).colorScheme.surfaceVariant
            : Theme.of(context).colorScheme.surfaceVariant.withOpacity(.5),
      ),
      child: InkWell(
        onTap: () {
          if (_lastReportedPage != index) {
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 250),
              curve: Curves.ease,
            );
          } else {
            // Todo open Week settings
          }
        },
        splashColor: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(99)),
        child: Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: item.selected ? .9 : .8,
            child: Text(
              _getItemText(item),
              textAlign: TextAlign.center,
              style: item.selected
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }

  String _getItemText(WeekItem item) {
    final Jiff jiff = Jiff(item.time);
    return '${jiff.year} | Week ${jiff.week}';
  }
}

class WeekItem {
  WeekItem(this.time, {this.selected = false});

  final DateTime time;

  bool selected;
}
