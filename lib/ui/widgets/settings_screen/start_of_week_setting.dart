import 'package:bottom_picker/bottom_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../../states/widgets/settings/start_of_week_state.dart';
import '../../../utils/start_of_week.dart';

class StartOfWeekSetting extends ConsumerWidget {
  const StartOfWeekSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StartOfWeekState state = ref.watch(startOfWeekProvider);

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              BottomPicker(
                title: tr('Start week on'),
                titleStyle: Theme.of(context).textTheme.bodyLarge!,
                onChange: (dynamic index) {
                  final int result = index as int;
                  ref
                      .read(startOfWeekProvider.notifier)
                      .setStartOfWeek(StartOfWeek.values[result]);
                },
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                pickerTextStyle: Theme.of(context).textTheme.bodyLarge!,
                displaySubmitButton: false,
                dismissable: true,
                closeIconColor: Colors.transparent,
                selectedItemIndex: StartOfWeek.values
                    .indexOf(state.startOfWeek ?? StartOfWeek.MONDAY),
                itemExtent: 36.sp,
                items: StartOfWeek.values
                    .map<Text>((StartOfWeek item) => Text(tr(item.toString())))
                    .toList(),
              ).show(context);
            },
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: ListTile(
              leading: Icon(
                Ionicons.calendar_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                tr('Start of week'),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: Text(
                tr(state.startOfWeek?.toString() ?? '-'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
