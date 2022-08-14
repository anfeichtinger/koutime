import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/day.dart';

class SickEntry extends StatelessWidget {
  const SickEntry({super.key, required this.day});

  final Day day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 96.sp,
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    DateFormat('E dd.MM', context.locale.toString())
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
                margin: EdgeInsets.only(right: 24.sp),
                height: 2.sp,
                width: 24.sp,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
              Icon(
                Ionicons.medkit,
                color: Theme.of(context).colorScheme.primary,
                size: 22.sp,
              ),
              Container(
                margin: EdgeInsets.only(left: 24.sp),
                height: 2.sp,
                width: 24.sp,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2),
                  ),
                ),
              ),
              Container(
                width: 96.sp,
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    DateFormat('E dd.MM', context.locale.toString())
                        .format(day.to),
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          if (day.comment != null && day.comment!.isNotEmpty) ...<Widget>[
            SizedBox(height: 6.sp),
            Text(
              day.comment!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
