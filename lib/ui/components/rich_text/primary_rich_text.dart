import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';

class PrimaryRichText extends StatefulWidget {
  final VoidCallback? onTapPrimaryHyperlink;
  final VoidCallback? onTapSecondaryHyperlink;

  const PrimaryRichText({
    super.key,
    this.onTapPrimaryHyperlink,
    this.onTapSecondaryHyperlink,
  });

  @override
  State<PrimaryRichText> createState() => _PrimaryRichTextState();
}

class _PrimaryRichTextState extends State<PrimaryRichText> {
  final TapGestureRecognizer primaryReconizer = TapGestureRecognizer();
  final TapGestureRecognizer secondaryReconizer = TapGestureRecognizer();

  @override
  void dispose() {
    primaryReconizer.dispose();
    secondaryReconizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
      textScaler: const TextScaler.linear(1),
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '''By signing in, you agree to TMDB's ''',
            style: TextStyle(
              color: greyColor,
              fontSize: 12.sp,
              height: 1.2.h,
            ),
          ),
          TextSpan(
            text: 'Conditions of Use',
            style: TextStyle(
              color: darkBlueColor,
              fontSize: 12.sp,
              height: 1.2.h,
            ),
            recognizer: primaryReconizer..onTap = widget.onTapPrimaryHyperlink,
          ),
          TextSpan(
            text: ' and ',
            style: TextStyle(
              color: greyColor,
              fontSize: 12.sp,
              height: 1.2.h,
            ),
          ),
          TextSpan(
            text: 'Privacy Notice.',
            style: TextStyle(
              color: darkBlueColor,
              fontSize: 12.sp,
              height: 1.2.h,
            ),
            recognizer: secondaryReconizer..onTap = widget.onTapSecondaryHyperlink,
          ),
        ],
      ),
    );
  }
}
