import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomScrollingButton extends StatelessWidget {
  final bool visible;
  final double opacity;
  final VoidCallback? onTap;
  const CustomScrollingButton({
    super.key,
    required this.opacity,
    this.onTap,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.9),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Visibility(
            visible: visible,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: greyColor,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_upward,
                color: darkBlueColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}