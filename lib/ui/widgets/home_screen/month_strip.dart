/*
* Credits go to: mahmed8003
* Git Repository: https://github.com/mahmed8003/month_picker_strip
*/

library month_strip;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class MonthStrip extends StatefulWidget {
  const MonthStrip(
      {super.key,
      this.format = 'MMM yyyy',
      required this.from,
      required this.to,
      required this.initialMonth,
      required this.onMonthChanged,
      this.physics,
      this.height = 48.0,
      this.viewportFraction = 0.45});

  final String format;
  final DateTime from;
  final DateTime to;
  final DateTime initialMonth;
  final ValueChanged<DateTime> onMonthChanged;
  final double height;
  final double viewportFraction;

  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  @override
  // ignore: no_logic_in_create_state
  MonthStripState createState() {
    final List<MonthItem> months = <MonthItem>[];
    int initialPage = 0;
    for (int i = from.year; i <= to.year; i++) {
      for (int j = 1; j <= 12; j++) {
        if (i == from.year && j < from.month) {
          continue;
        }

        if (i == to.year && j > to.month) {
          continue;
        }

        final MonthItem item = MonthItem(DateTime(i, j));
        if (item.time.year == initialMonth.year &&
            item.time.month == initialMonth.month) {
          initialPage = months.length;
          item.selected = true;
        }
        months.add(item);
      }
    }

    return MonthStripState(
        viewportFraction: viewportFraction,
        initialPage: initialPage,
        months: months);
  }
}

class MonthStripState extends State<MonthStrip> {
  MonthStripState(
      {required double viewportFraction,
      required int initialPage,
      required this.months})
      : controller = PageController(
            viewportFraction: viewportFraction, initialPage: initialPage),
        _lastReportedPage = initialPage;
  final List<MonthItem> months;
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
                for (final MonthItem item in months) {
                  item.selected = false;
                }
                final MonthItem m = months[currentPage];
                final DateTime d = m.time;
                m.selected = true;
                widget.onMonthChanged(DateTime(d.year, d.month));
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
                      childCount: months.length),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int index) {
    final MonthItem item = months[index];
    return AnimatedContainer(
      margin: item.selected ? EdgeInsets.all(6.sp) : EdgeInsets.all(8.sp),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(99)),
        color: item.selected
            ? Theme.of(context).bottomAppBarColor
            : Theme.of(context).bottomAppBarColor.withOpacity(.5),
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
            // Todo open month settings
          }
        },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(99)),
        child: Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: item.selected ? .9 : .8,
            child: Text(
              DateFormat(widget.format, context.locale.toString())
                  .format(item.time),
              textAlign: TextAlign.center,
              style: item.selected
                  ? Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(fontWeightDelta: 2)
                  : Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ),
    );
  }
}

class MonthItem {
  MonthItem(this.time, {this.selected = false});

  final DateTime time;

  bool selected;
}
