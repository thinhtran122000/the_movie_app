import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final double? height;
  final List<Widget> tabs;
  final Color? backgroundColor;
  const CustomTabBar({
    super.key,
    this.height,
    this.tabs = const [],
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: tabs,
      ),
    );
  }
}
