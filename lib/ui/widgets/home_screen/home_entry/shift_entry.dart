import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/enums/day_usage_enum.dart';
import '../../../../data/models/day.dart';
import '../../card_rounded.dart';

class ShiftEntry extends StatelessWidget {
  const ShiftEntry({super.key, required this.day});

  final Day day;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CardRounded(
      margin: EdgeInsets.symmetric(vertical: 6.sp),
      onPress: () {},
      leading: Hero(
        tag: 'day_id_${day.id}',
        child: Container(
          height: 48.sp,
          width: 48.sp,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(36)),
              border: Border.all(width: 3, color: theme.colorScheme.primary)),
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
      contentPadding: const EdgeInsets.only(left: 16),
      subtitle: _getSubtitle(theme),
      isThreeLine: _getIsThreeLine(),
      child: Row(
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
    );
  }

  Widget? _getSubtitle(ThemeData theme) {
    if (day.usage == DayUsage.sick) {
      return null;
    }
    final String subtitleText = _getSubtitleText();
    final bool isThreeLine = _getIsThreeLine();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(subtitleText.isEmpty ? tr('No Break') : subtitleText,
            style: theme.textTheme.bodyMedium),
        if (isThreeLine)
          Text(day.comment ?? '', style: theme.textTheme.bodyMedium)
        else
          const SizedBox()
      ],
    );
  }

  String _getSubtitleText() {
    if (day.breaks.isNotEmpty) {
      return day.breaks.first.getFormattedString();
    } else {
      return (day.comment != null && day.comment!.isNotEmpty)
          ? day.comment!
          : '';
    }
  }

  bool _getIsThreeLine() {
    return day.breaks.isNotEmpty &&
        day.comment != null &&
        day.comment!.isNotEmpty;
  }
}
