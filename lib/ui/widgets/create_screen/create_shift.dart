import 'package:bottom_picker/bottom_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/break.dart';
import '../../../data/models/day.dart';
import '../../../states/screens/create_screen/create_day_states.dart';
import 'section_title.dart';

class CreateShift extends ConsumerWidget {
  const CreateShift({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Day day = ref.watch(createDayProvider).day;
    final TextEditingController commentController =
        TextEditingController(text: day.comment);

    return ListView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Card(
          elevation: 1,
          shadowColor: Theme.of(context).colorScheme.shadow,
          color: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Ionicons.time_outline,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
                title: GestureDetector(
                  onTap: () {
                    BottomPicker.date(
                      title: tr('Shift from'),
                      titleStyle: Theme.of(context).textTheme.bodyLarge!,
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.from = DateTime(result.year, result.month,
                            result.day, day.from.hour, day.from.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      pickerTextStyle: Theme.of(context).textTheme.bodyLarge!,
                      initialDateTime: day.from,
                      minDateTime: DateTime(1970),
                      maxDateTime: DateTime.now().add(
                        const Duration(days: 1826), // +5 years
                      ),
                      displaySubmitButton: false,
                      dismissable: true,
                      closeIconColor: Colors.transparent,
                    ).show(context);
                  },
                  child: Text(
                    DateFormat('E d MMM y', context.locale.toString())
                        .format(day.from),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    BottomPicker.time(
                      title: tr('Shift from'),
                      titleStyle: Theme.of(context).textTheme.bodyLarge!,
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.from = DateTime(day.from.year, day.from.month,
                            day.from.day, result.hour, result.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      use24hFormat:
                          MediaQuery.of(context).alwaysUse24HourFormat,
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      pickerTextStyle: Theme.of(context).textTheme.bodyLarge!,
                      initialDateTime: day.from,
                      minDateTime: DateTime(1970),
                      maxDateTime: DateTime.now().add(
                        const Duration(days: 1826), // +5 years
                      ),
                      displaySubmitButton: false,
                      dismissable: true,
                      closeIconColor: Colors.transparent,
                    ).show(context);
                  },
                  child: Text(
                    DateFormat(
                            'H:mm',
                            context.locale
                                .toString()) // Todo get 24h format from prefs
                        .format(day.from),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              ListTile(
                leading: const SizedBox(),
                title: GestureDetector(
                  onTap: () {
                    BottomPicker.date(
                      title: tr('Shift until'),
                      titleStyle: Theme.of(context).textTheme.bodyLarge!,
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.to = DateTime(result.year, result.month, result.day,
                            day.to.hour, day.to.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      pickerTextStyle: Theme.of(context).textTheme.bodyLarge!,
                      initialDateTime: day.to,
                      minDateTime: DateTime(1970),
                      maxDateTime: DateTime.now().add(
                        const Duration(days: 1826), // +5 years
                      ),
                      displaySubmitButton: false,
                      dismissable: true,
                      closeIconColor: Colors.transparent,
                    ).show(context);
                  },
                  child: Text(
                    DateFormat('E d MMM y', context.locale.toString())
                        .format(day.to),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    BottomPicker.time(
                      title: tr('Shift until'),
                      titleStyle: Theme.of(context).textTheme.bodyLarge!,
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.to = DateTime(day.to.year, day.to.month, day.to.day,
                            result.hour, result.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      use24hFormat:
                          MediaQuery.of(context).alwaysUse24HourFormat,
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      pickerTextStyle: Theme.of(context).textTheme.bodyLarge!,
                      initialDateTime: day.to,
                      minDateTime: DateTime(1970),
                      maxDateTime: DateTime.now().add(
                        const Duration(days: 1826), // +5 years
                      ),
                      displaySubmitButton: false,
                      dismissable: true,
                      closeIconColor: Colors.transparent,
                    ).show(context);
                  },
                  child: Text(
                    DateFormat('H:mm', context.locale.toString())
                        .format(day.to),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.sp),
        SectionTitle(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          text: 'Breaks',
          trailing: InkWell(
            onTap: () async {
              final DateTime from = day.from.add(const Duration(hours: 4));
              final Break newBreak = Break(
                from: from,
                to: from.add(const Duration(minutes: 30)),
              );
              day.breaks.add(newBreak);
              ref.read(createDayProvider.notifier).day = day;
              BottomPicker.time(
                title: tr('Break from'),
                titleStyle: Theme.of(context).textTheme.bodyLarge!,
                onChange: (dynamic index) {
                  final DateTime result = index as DateTime;
                  day.breaks.removeLast();
                  newBreak.from = DateTime(
                      newBreak.from.year,
                      newBreak.from.month,
                      newBreak.from.day,
                      result.hour,
                      result.minute);
                  day.breaks.add(newBreak);
                  ref.read(createDayProvider.notifier).day = day;
                },
                use24hFormat: MediaQuery.of(context).alwaysUse24HourFormat,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                pickerTextStyle: Theme.of(context).textTheme.bodyLarge!,
                initialDateTime: newBreak.from,
                minDateTime: day.from,
                maxDateTime: day.to,
                displaySubmitButton: false,
                dismissable: true,
                closeIconColor: Colors.transparent,
              ).show(context);
            },
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                tr('Add'),
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeightDelta: 2,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.sp),
        if (day.breaks.isEmpty)
          Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Ionicons.cafe_outline,
                  size: 22.sp,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
                Text(
                  tr('No break'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )
        else
          ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: day.breaks
                  .map<Widget>(
                    (Break brk) => Card(
                      elevation: 1,
                      shadowColor: Theme.of(context).colorScheme.shadow,
                      color: Theme.of(context).colorScheme.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 12, right: 16),
                            leading: InkWell(
                              onTap: () {
                                day.breaks.remove(brk);
                                ref.read(createDayProvider.notifier).day = day;
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(32)),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Ionicons.close_outline,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: GestureDetector(
                                onTap: () {
                                  BottomPicker.date(
                                    title: tr('Break from'),
                                    titleStyle:
                                        Theme.of(context).textTheme.bodyLarge!,
                                    onChange: (dynamic index) {
                                      final DateTime result = index as DateTime;
                                      brk.from = DateTime(
                                          result.year,
                                          result.month,
                                          result.day,
                                          brk.from.hour,
                                          brk.from.minute);
                                      ref.read(createDayProvider.notifier).day =
                                          day;
                                    },
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    pickerTextStyle:
                                        Theme.of(context).textTheme.bodyLarge!,
                                    initialDateTime: brk.from,
                                    minDateTime: day.from,
                                    maxDateTime: day.to,
                                    displaySubmitButton: false,
                                    dismissable: true,
                                    closeIconColor: Colors.transparent,
                                  ).show(context);
                                },
                                child: Text(
                                  DateFormat('E d MMM y',
                                          context.locale.toString())
                                      .format(brk.from),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                BottomPicker.time(
                                  title: tr('Break from'),
                                  titleStyle:
                                      Theme.of(context).textTheme.bodyLarge!,
                                  onChange: (dynamic index) {
                                    final DateTime result = index as DateTime;
                                    day.breaks.removeLast();
                                    brk.from = DateTime(
                                        brk.from.year,
                                        brk.from.month,
                                        brk.from.day,
                                        result.hour,
                                        result.minute);
                                    day.breaks.add(brk);
                                    ref.read(createDayProvider.notifier).day =
                                        day;
                                  },
                                  use24hFormat: MediaQuery.of(context)
                                      .alwaysUse24HourFormat,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  pickerTextStyle:
                                      Theme.of(context).textTheme.bodyLarge!,
                                  initialDateTime: brk.from,
                                  minDateTime: day.from,
                                  maxDateTime: day.to,
                                  displaySubmitButton: false,
                                  dismissable: true,
                                  closeIconColor: Colors.transparent,
                                ).show(context);
                              },
                              child: Text(
                                DateFormat('H:mm', context.locale.toString())
                                    .format(brk.from),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const SizedBox(),
                            title: GestureDetector(
                              onTap: () {
                                BottomPicker.date(
                                  title: tr('Break until'),
                                  titleStyle:
                                      Theme.of(context).textTheme.bodyLarge!,
                                  onChange: (dynamic index) {
                                    final DateTime result = index as DateTime;
                                    brk.to = DateTime(result.year, result.month,
                                        result.day, brk.to.hour, brk.to.minute);
                                    ref.read(createDayProvider.notifier).day =
                                        day;
                                  },
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  pickerTextStyle:
                                      Theme.of(context).textTheme.bodyLarge!,
                                  initialDateTime: brk.to,
                                  minDateTime: day.from,
                                  maxDateTime: day.to,
                                  displaySubmitButton: false,
                                  dismissable: true,
                                  closeIconColor: Colors.transparent,
                                ).show(context);
                              },
                              child: Text(
                                DateFormat(
                                        'E d MMM y', context.locale.toString())
                                    .format(brk.to),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                BottomPicker.time(
                                  title: tr('Break until'),
                                  titleStyle:
                                      Theme.of(context).textTheme.bodyLarge!,
                                  onChange: (dynamic index) {
                                    final DateTime result = index as DateTime;
                                    day.breaks.removeLast();
                                    brk.to = DateTime(brk.to.year, brk.to.month,
                                        brk.to.day, result.hour, result.minute);
                                    day.breaks.add(brk);
                                    ref.read(createDayProvider.notifier).day =
                                        day;
                                  },
                                  use24hFormat: MediaQuery.of(context)
                                      .alwaysUse24HourFormat,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  pickerTextStyle:
                                      Theme.of(context).textTheme.bodyLarge!,
                                  initialDateTime: brk.to,
                                  minDateTime: day.from,
                                  maxDateTime: day.to,
                                  displaySubmitButton: false,
                                  dismissable: true,
                                  closeIconColor: Colors.transparent,
                                ).show(context);
                              },
                              child: Text(
                                DateFormat('H:mm', context.locale.toString())
                                    .format(brk.to),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()),
        SizedBox(height: 24.sp),
        const SectionTitle(
          padding: EdgeInsets.symmetric(horizontal: 4),
          text: 'Additional',
        ),
        SizedBox(height: 4.sp),
        Card(
          elevation: 1,
          shadowColor: Theme.of(context).colorScheme.shadow,
          color: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  BottomPicker(
                    title: tr('Rate'),
                    titleStyle: Theme.of(context).textTheme.bodyLarge!,
                    onChange: (dynamic index) {
                      final int result = index as int;
                      day.multiplier =
                          double.parse((result * 0.1 + 0.1).toStringAsFixed(1));
                      ref.read(createDayProvider.notifier).day = day;
                    },
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceVariant,
                    pickerTextStyle: Theme.of(context).textTheme.bodyLarge!,
                    displaySubmitButton: false,
                    dismissable: true,
                    closeIconColor: Colors.transparent,
                    selectedItemIndex: (day.multiplier ~/ 0.1) - 1,
                    itemExtent: 28.sp,
                    items: List<Text>.generate(
                      50,
                      (int index) => Text(
                        (index * 0.1 + 0.1).toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ).show(context);
                },
                splashColor: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: ListTile(
                  leading: Icon(
                    Ionicons.medical_outline,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                  title: Text(
                    tr('Rate'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: Text(
                    'x ${day.multiplier.toString()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Ionicons.chatbubble_ellipses_outline,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
                title: TextFormField(
                  controller: commentController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.labelLarge,
                  decoration: InputDecoration(
                    hintText: tr('Add comment...'),
                    hintStyle: Theme.of(context).textTheme.labelLarge!.apply(
                          fontWeightDelta: -1,
                          fontSizeDelta: -1.sp,
                          color: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .color!
                              .withOpacity(0.6),
                        ),
                    border: InputBorder.none,
                  ),
                  onChanged: (String comment) {
                    day.comment = comment;
                  },
                  onEditingComplete: () {
                    ref.read(createDayProvider.notifier).day = day;
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 52.sp),
      ],
    );
  }
}
