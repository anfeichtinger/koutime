import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../config/theme.dart';
import '../../../data/enums/day_usage_enum.dart';
import '../../../data/models/day.dart';

class HomeEntry extends StatelessWidget {
  const HomeEntry({super.key, required this.day});

  final Day day;

  @override
  Widget build(BuildContext context) {
    switch (day.usage) {
      case DayUsage.free:
      case DayUsage.holiday:
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: textSwatch.shade400),
                child: Center(
                  child: Text(
                    DateFormat('E d.', context.locale.toString())
                        .format(day.from),
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 12),
                height: 2,
                width: 24,
                decoration: BoxDecoration(
                  color: textSwatch.shade400,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
              Icon(
                day.usage == DayUsage.holiday
                    ? Ionicons.sunny
                    : Ionicons.airplane,
                color: textSwatch.shade400,
                size: 20,
              ),
              if (day.to.difference(day.from).inDays > 0) ...<Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  height: 2,
                  width: 24,
                  decoration: BoxDecoration(
                    color: textSwatch.shade400,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: textSwatch.shade400),
                  child: Center(
                    child: Text(
                      DateFormat('E d.', context.locale.toString())
                          .format(day.to),
                      softWrap: false,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: Colors.white),
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      case DayUsage.sick:
        return const SizedBox();
      case DayUsage.shift:
        return const SizedBox();
    }
  }
}
