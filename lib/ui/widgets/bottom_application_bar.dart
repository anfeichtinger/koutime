import 'package:flutter/material.dart';

class BottomApplicationBar extends StatelessWidget {
  const BottomApplicationBar(
      {super.key,
      this.leftWidgets = const <Widget>[],
      this.rightWidgets = const <Widget>[]});

  final List<Widget> leftWidgets;
  final List<Widget> rightWidgets;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'bottom_application_bar',
      placeholderBuilder: (BuildContext context, Size size, Widget widget) {
        return SizedBox(
          width: size.width,
          height: size.height,
        );
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Theme.of(context).bottomAppBarColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Row(children: leftWidgets),
              const Spacer(),
              const SizedBox(height: 48),
              const Spacer(),
              Row(children: rightWidgets),
            ],
          ),
        ),
      ),
    );
  }
}