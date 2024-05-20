import 'package:flutter/material.dart';
import 'package:tmdb/shared_ui/colors/color.dart';

class StreamingView extends StatelessWidget {
  const StreamingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Coming soon on TMDb',
        style: TextStyle(
          color: blackColor,
        ),
      ),
    );
  }
}
