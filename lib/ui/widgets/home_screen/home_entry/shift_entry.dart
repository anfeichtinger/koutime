import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/day.dart';

class ShiftEntry extends StatelessWidget {
  const ShiftEntry({super.key, required this.day});

  final Day day;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 1,
      shadowColor: Theme.of(context).colorScheme.shadow,
      margin: EdgeInsets.symmetric(vertical: 6.sp),
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: InkWell(
        onTap: () {},
        onLongPress: () {},
        splashColor: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: ListTile(
          dense: true,
          isThreeLine: isThreeLine(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Hero(
            tag: 'day_id_${day.id}',
            child: Container(
              height: 48.sp,
              width: 48.sp,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                  border:
                      Border.all(width: 3, color: theme.colorScheme.primary)),
              child: Center(
                child: Text(
                  day.from.day != day.to.day
                      ? '${day.from.day}-${day.to.day}'
                      : '${day.from.day}',
                  style: day.from.day != day.to.day
                      ? theme.textTheme.bodySmall!.apply(
                          color: theme.colorScheme.primary,
                          fontWeightDelta: 6,
                        )
                      : theme.textTheme.titleLarge!.apply(
                          color: theme.colorScheme.primary,
                        ),
                  softWrap: false,
                ),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(day.getFormattedString(), style: theme.textTheme.bodyLarge),
              Text(
                '${day.getActiveHourCount()}h',
                style: theme.textTheme.labelLarge!
                    .apply(color: theme.colorScheme.primary),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(subtitleText().isEmpty ? tr('No Break') : subtitleText(),
                  style: theme.textTheme.bodyMedium),
              if (isThreeLine())
                Text(day.comment ?? '', style: theme.textTheme.bodyMedium)
              else
                const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  String subtitleText() {
    if (day.breaks.isNotEmpty) {
      return day.breaks.first.getFormattedString();
    } else {
      return (day.comment != null && day.comment!.isNotEmpty)
          ? day.comment!
          : '';
    }
  }

  bool isThreeLine() {
    return day.breaks.isNotEmpty &&
        day.comment != null &&
        day.comment!.isNotEmpty;
  }
}
