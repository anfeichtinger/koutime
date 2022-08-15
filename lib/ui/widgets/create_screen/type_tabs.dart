import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/enums/day_usage_enum.dart';
import '../../../data/models/day.dart';
import '../../../states/screens/create_screen/create_day_states.dart';

class TypeTabs extends ConsumerWidget {
  const TypeTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayUsage currentUsage = ref.watch(createDayProvider).day.usage;
    final Map<DayUsage, String> labels = <DayUsage, String>{
      DayUsage.shift: tr('Shift'),
      DayUsage.free: tr('Vacation'),
      DayUsage.sick: tr('Sick')
    };
    final Map<DayUsage, IconData> icons = <DayUsage, IconData>{
      DayUsage.shift: Ionicons.briefcase_outline,
      DayUsage.free: Ionicons.airplane_outline,
      DayUsage.sick: Ionicons.medkit_outline
    };
    final ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          height: 40,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(.4),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final bool isCurrent =
                  currentUsage == labels.keys.elementAt(index);
              return InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: AnimatedContainer(
                  width: (constraints.maxWidth - 6) / 3,
                  decoration: BoxDecoration(
                      color:
                          isCurrent ? theme.colorScheme.surfaceVariant : null,
                      border: isCurrent
                          ? Border.all(
                              color: theme.colorScheme.shadow,
                              width: 0.75,
                            )
                          : null,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  duration: const Duration(milliseconds: 250),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(icons.values.elementAt(index),
                            size: 16,
                            color:
                                (currentUsage == labels.keys.elementAt(index))
                                    ? theme.colorScheme.primary
                                    : theme.textTheme.bodyMedium!.color),
                        const SizedBox(width: 6),
                        Text(labels.values.elementAt(index),
                            textAlign: TextAlign.center,
                            style: (currentUsage ==
                                    labels.keys.elementAt(index))
                                ? theme.textTheme.bodyMedium!
                                    .copyWith(color: theme.colorScheme.primary)
                                : theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  if (labels.keys.elementAt(index) != currentUsage) {
                    final Day day = ref.read(createDayProvider).day;
                    day.usage = labels.keys.elementAt(index);
                    ref.read(createDayProvider.notifier).day = day;
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
