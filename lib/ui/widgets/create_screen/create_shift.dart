import 'package:bottom_picker/bottom_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

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
          elevation: 0,
          color: Theme.of(context).cardColor,
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
                  color: Theme.of(context).textTheme.caption!.color,
                ),
                title: GestureDetector(
                  onTap: () {
                    BottomPicker.date(
                      title: tr('Shift start'),
                      titleStyle: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .apply(fontWeightDelta: 2),
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.from = DateTime(result.year, result.month,
                            result.day, day.from.hour, day.from.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      backgroundColor: Theme.of(context).cardColor,
                      pickerTextStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .apply(fontWeightDelta: 2, fontSizeDelta: -2),
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
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    BottomPicker.time(
                      title: tr('Shift start'),
                      titleStyle: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .apply(fontWeightDelta: 2),
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.from = DateTime(day.from.year, day.from.month,
                            day.from.day, result.hour, result.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      use24hFormat:
                          MediaQuery.of(context).alwaysUse24HourFormat,
                      backgroundColor: Theme.of(context).cardColor,
                      pickerTextStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .apply(fontWeightDelta: 2, fontSizeDelta: -2),
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
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              ListTile(
                leading: const SizedBox(),
                title: GestureDetector(
                  onTap: () {
                    BottomPicker.date(
                      title: tr('Shift end'),
                      titleStyle: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .apply(fontWeightDelta: 2),
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.to = DateTime(result.year, result.month, result.day,
                            day.to.hour, day.to.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      backgroundColor: Theme.of(context).cardColor,
                      pickerTextStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .apply(fontWeightDelta: 2, fontSizeDelta: -2),
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
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    BottomPicker.time(
                      title: tr('Shift end'),
                      titleStyle: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .apply(fontWeightDelta: 2),
                      onChange: (dynamic index) {
                        final DateTime result = index as DateTime;
                        day.to = DateTime(day.to.year, day.to.month, day.to.day,
                            result.hour, result.minute);
                        ref.read(createDayProvider.notifier).day = day;
                      },
                      use24hFormat:
                          MediaQuery.of(context).alwaysUse24HourFormat,
                      backgroundColor: Theme.of(context).cardColor,
                      pickerTextStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .apply(fontWeightDelta: 2, fontSizeDelta: -2),
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
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.sp),
        if (day.breakFrom == null)
          Card(
            elevation: 0,
            color: Theme.of(context).cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: InkWell(
              onTap: () {
                day.breakFrom ??= day.from;
                day.breakTo ??= day.to;
                ref.read(createDayProvider.notifier).day = day;

                BottomPicker.time(
                  title: tr('Break start'),
                  titleStyle: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .apply(fontWeightDelta: 2),
                  onChange: (dynamic index) {
                    final DateTime result = index as DateTime;
                    day.breakFrom = DateTime(
                        day.breakFrom?.year ?? day.from.year,
                        day.breakFrom?.month ?? day.from.month,
                        day.breakFrom?.day ?? day.from.day,
                        result.hour,
                        result.minute);
                    ref.read(createDayProvider.notifier).day = day;
                  },
                  use24hFormat: MediaQuery.of(context).alwaysUse24HourFormat,
                  backgroundColor: Theme.of(context).cardColor,
                  pickerTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                  initialDateTime: day.breakFrom,
                  minDateTime: day.from,
                  maxDateTime: day.to,
                  displaySubmitButton: false,
                  dismissable: true,
                  closeIconColor: Colors.transparent,
                ).show(context);
              },
              splashColor: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: ListTile(
                leading: Icon(
                  Ionicons.cafe_outline,
                  color: Theme.of(context).textTheme.caption!.color,
                ),
                title: Text(
                  tr('Add break...'),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
          )
        else
          Card(
            elevation: 0,
            color: Theme.of(context).cardColor,
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
                    Ionicons.cafe_outline,
                    color: Theme.of(context).textTheme.caption!.color,
                  ),
                  title: GestureDetector(
                    onTap: () {
                      BottomPicker.date(
                        title: tr('Break start'),
                        titleStyle: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .apply(fontWeightDelta: 2),
                        onChange: (dynamic index) {
                          final DateTime result = index as DateTime;
                          day.breakFrom = DateTime(
                            result.year,
                            result.month,
                            result.day,
                            day.breakFrom?.hour ?? day.from.hour,
                            day.breakFrom?.minute ?? day.from.minute,
                          );
                          ref.read(createDayProvider.notifier).day = day;
                        },
                        backgroundColor: Theme.of(context).cardColor,
                        pickerTextStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                        initialDateTime: day.breakFrom,
                        minDateTime: day.from,
                        maxDateTime: day.to,
                        displaySubmitButton: false,
                        dismissable: true,
                        closeIconColor: Colors.transparent,
                      ).show(context);
                    },
                    child: Text(
                      DateFormat(
                        'E d MMM y',
                        context.locale.toString(),
                      ).format(day.breakFrom!),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      BottomPicker.time(
                        title: tr('Break start'),
                        titleStyle: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .apply(fontWeightDelta: 2),
                        onChange: (dynamic index) {
                          final DateTime result = index as DateTime;
                          day.breakFrom = DateTime(
                              day.breakFrom?.year ?? day.from.year,
                              day.breakFrom?.month ?? day.from.month,
                              day.breakFrom?.day ?? day.from.day,
                              result.hour,
                              result.minute);
                          ref.read(createDayProvider.notifier).day = day;
                        },
                        use24hFormat:
                            MediaQuery.of(context).alwaysUse24HourFormat,
                        backgroundColor: Theme.of(context).cardColor,
                        pickerTextStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                        initialDateTime: day.breakFrom,
                        minDateTime: day.from,
                        maxDateTime: day.to,
                        displaySubmitButton: false,
                        dismissable: true,
                        closeIconColor: Colors.transparent,
                      ).show(context);
                    },
                    child: Text(
                      DateFormat(
                        'H:mm', // Todo get 24h format from prefs
                        context.locale.toString(),
                      ).format(day.breakFrom!),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(
                      Ionicons.close_outline,
                      color: Theme.of(context).errorColor,
                    ),
                    visualDensity: VisualDensity.compact,
                    splashRadius: 16,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints.tightFor(width: 20, height: 20),
                    onPressed: () {
                      day.breakFrom = null;
                      day.breakTo = null;
                      ref.read(createDayProvider.notifier).day = day;
                    },
                  ),
                  title: GestureDetector(
                    onTap: () {
                      BottomPicker.date(
                        title: tr('Break end'),
                        titleStyle: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .apply(fontWeightDelta: 2),
                        onChange: (dynamic index) {
                          final DateTime result = index as DateTime;
                          day.breakTo = DateTime(
                            result.year,
                            result.month,
                            result.day,
                            day.breakTo?.hour ?? day.to.hour,
                            day.breakTo?.minute ?? day.to.minute,
                          );
                          ref.read(createDayProvider.notifier).day = day;
                        },
                        backgroundColor: Theme.of(context).cardColor,
                        pickerTextStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                        initialDateTime: day.breakTo,
                        minDateTime: day.from,
                        maxDateTime: day.to,
                        displaySubmitButton: false,
                        dismissable: true,
                        closeIconColor: Colors.transparent,
                      ).show(context);
                    },
                    child: Text(
                      DateFormat(
                        'E d MMM y',
                        context.locale.toString(),
                      ).format(day.breakTo!),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      BottomPicker.time(
                        title: tr('Break end'),
                        titleStyle: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .apply(fontWeightDelta: 2),
                        onChange: (dynamic index) {
                          final DateTime result = index as DateTime;
                          day.breakTo = DateTime(
                            day.breakTo?.year ?? day.to.year,
                            day.breakTo?.month ?? day.to.month,
                            day.breakTo?.day ?? day.to.day,
                            result.hour,
                            result.minute,
                          );
                          ref.read(createDayProvider.notifier).day = day;
                        },
                        use24hFormat:
                            MediaQuery.of(context).alwaysUse24HourFormat,
                        backgroundColor: Theme.of(context).cardColor,
                        pickerTextStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                        initialDateTime: day.breakTo,
                        minDateTime: day.from,
                        maxDateTime: day.to,
                        displaySubmitButton: false,
                        dismissable: true,
                        closeIconColor: Colors.transparent,
                      ).show(context);
                    },
                    child: Text(
                      DateFormat(
                        'H:mm',
                        context.locale.toString(),
                      ).format(day.to),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 18.sp),
        const SectionTitle(
          padding: EdgeInsets.symmetric(horizontal: 4),
          text: 'Additional',
        ),
        SizedBox(height: 4.sp),
        Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  BottomPicker(
                    title: tr('Rate'),
                    titleStyle: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .apply(fontWeightDelta: 2),
                    onChange: (dynamic index) {
                      final int result = index as int;
                      day.multiplier =
                          double.parse((result * 0.1 + 0.1).toStringAsFixed(1));
                      ref.read(createDayProvider.notifier).day = day;
                    },
                    backgroundColor: Theme.of(context).cardColor,
                    pickerTextStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .apply(fontWeightDelta: 2, fontSizeDelta: 2.sp),
                    displaySubmitButton: false,
                    dismissable: true,
                    closeIconColor: Colors.transparent,
                    selectedItemIndex: (day.multiplier ~/ 0.1) - 1,
                    itemExtent: 28.sp,
                    items: List<Text>.generate(
                      50,
                      (int index) => Text(
                        (index * 0.1 + 0.1).toStringAsFixed(1),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .apply(fontWeightDelta: 2, fontSizeDelta: 2.sp),
                      ),
                    ),
                  ).show(context);
                },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: ListTile(
                  leading: Icon(
                    Ionicons.medical_outline,
                    color: Theme.of(context).textTheme.caption!.color,
                  ),
                  title: Text(
                    tr('Rate'),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: Text('x ${day.multiplier.toString()}'),
                ),
              ),
              ListTile(
                leading: Icon(
                  Ionicons.chatbubble_ellipses_outline,
                  color: Theme.of(context).textTheme.caption!.color,
                ),
                title: TextFormField(
                  controller: commentController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.subtitle2,
                  decoration: InputDecoration(
                    hintText: tr('Add comment...'),
                    hintStyle: Theme.of(context).textTheme.bodyText1!.apply(
                          fontWeightDelta: -1,
                          fontSizeDelta: -1.sp,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
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
      ],
    );
  }
}
