import 'package:flutter/material.dart';

class AppPageRoute<Object> extends PageRouteBuilder<Object> {
  final RouteSettings? routeSettings;
  final Widget Function(BuildContext) builder;
  final Offset begin;
  AppPageRoute({
    this.routeSettings,
    required this.builder,
    required this.begin,
  }) : super(
          settings: routeSettings,
          barrierColor: null,
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              transformHitTests: false,
              position: Tween<Offset>(
                begin: begin,
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
        );
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}
