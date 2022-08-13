import 'package:bottom_picker/bottom_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/day.dart';
import '../../../states/screens/create_screen/create_day_states.dart';
import 'section_title.dart';

class CreateSick extends ConsumerWidget {
  const CreateSick({super.key});

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
          color: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  BottomPicker.date(
                    title: tr('Sick leave from'),
                    titleStyle: Theme.of(context).textTheme.bodyLarge!,
                    onChange: (dynamic index) {
                      final DateTime result = index as DateTime;
                      day.from = DateTime(result.year, result.month, result.day,
                          day.from.hour, day.from.minute);
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
                child: ListTile(
                  // visualDensity: VisualDensity.compact,
                  leading: Icon(
                    Ionicons.time_outline,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                  title: Text(
                    tr('From'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: Text(
                    DateFormat('E d MMM y', context.locale.toString())
                        .format(day.from),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  BottomPicker.date(
                    title: tr('Sick leave until'),
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
                child: ListTile(
                  // visualDensity: VisualDensity.compact,
                  leading: const SizedBox(),
                  title: Text(
                    'Until',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: Text(
                    DateFormat('E d MMM y', context.locale.toString())
                        .format(day.to),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.sp),
        const SectionTitle(
          padding: EdgeInsets.symmetric(horizontal: 4),
          text: 'Additional',
        ),
        SizedBox(height: 4.sp),
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: ListTile(
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
        ),
      ],
    );
  }
}
