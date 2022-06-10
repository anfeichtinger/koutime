import 'package:bottom_picker/bottom_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/day.dart';
import '../../../states/screens/create_screen/create_day_states.dart';
import 'section_title.dart';

class CreateShift extends ConsumerWidget {
  const CreateShift({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Day day = ref.watch(createDayProvider).day;

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
              Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                visualDensity: VisualDensity.compact,
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
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              ListTile(
                visualDensity: VisualDensity.compact,
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
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionTitle(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          text: 'Breaks',
          trailing: RawMaterialButton(
            onPressed: () {},
            fillColor: Theme.of(context).primaryColor,
            splashColor: Theme.of(context).dividerColor,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Ionicons.add_outline,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  tr('Add'),
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .apply(color: Colors.white, fontSizeDelta: -2),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'No break...',
              style: Theme.of(context).textTheme.bodyText1!.apply(
                  fontWeightDelta: -1,
                  fontSizeDelta: -1,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.6)),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const SectionTitle(
          padding: EdgeInsets.symmetric(horizontal: 4),
          text: 'Additional',
        ),
        const SizedBox(height: 4),
        Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  // Todo number picker
                  BottomPicker(
                    title: tr('Rate'),
                    titleStyle: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .apply(fontWeightDelta: 2),
                    onChange: (dynamic index) {
                      final int result = index as int;
                    },
                    backgroundColor: Theme.of(context).cardColor,
                    pickerTextStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .apply(fontWeightDelta: 2, fontSizeDelta: -2),
                    displaySubmitButton: false,
                    dismissable: true,
                    closeIconColor: Colors.transparent,
                    items: const <Text>[
                      Text('0.1'),
                      Text('0.2'),
                      Text('0.3'),
                      Text('0.4'),
                      Text('0.5'),
                      Text('0.6'),
                      Text('0.7'),
                      Text('0.8'),
                    ],
                  ).show(context);
                },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: ListTile(
                  visualDensity: VisualDensity.compact,
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
                visualDensity: VisualDensity.compact,
                leading: Icon(
                  Ionicons.chatbubble_ellipses_outline,
                  color: Theme.of(context).textTheme.caption!.color,
                ),
                title: TextFormField(
                  keyboardType: TextInputType.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(fontWeightDelta: -1, fontSizeDelta: -1),
                  decoration: InputDecoration(
                      hintText: tr('Add comment...'),
                      hintStyle: Theme.of(context).textTheme.bodyText1!.apply(
                          fontWeightDelta: -1,
                          fontSizeDelta: -1,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.6)),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
