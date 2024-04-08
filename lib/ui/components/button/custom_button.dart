import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CreateAccountButton extends StatelessWidget {
  final void Function()? onTap;
  const CreateAccountButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: darkBlueButtonStyle,
      child: Text(
        'Create an account',
        textScaler: const TextScaler.linear(1),
        style: TextStyle(
          color: whiteColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final void Function()? onTap;
  const LoginButton({
    this.title,
    super.key,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: whiteButtonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          icon ?? const SizedBox(),
          const Spacer(),
          Flexible(
            flex: 3,
            child: Text(
              '$title',
              textAlign: TextAlign.left,
              softWrap: false,
              textScaler: const TextScaler.linear(1),
              style: TextStyle(
                color: blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
