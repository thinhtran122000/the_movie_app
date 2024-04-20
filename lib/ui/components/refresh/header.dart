import 'package:flutter/material.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) => MaterialClassicHeader(color: darkBlueColor);
}
