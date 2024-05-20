import 'package:flutter/material.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

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
