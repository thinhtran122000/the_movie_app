import 'package:flutter/material.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class InTheatersView extends StatelessWidget {
  const InTheatersView({super.key});

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
