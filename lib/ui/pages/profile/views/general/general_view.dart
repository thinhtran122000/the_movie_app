import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tmdb/ui/pages/profile/views/general/views/introduction/introduction_view.dart';

class GeneralView extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  const GeneralView({
    super.key,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IntroductionView(
            navigatorKey: navigatorKey,
          ),
        ],
      ),
    );
  }
}
