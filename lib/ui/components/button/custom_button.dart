import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CreateAccountButton extends StatelessWidget {
  final void Function()? onTap;
  final ButtonStyle? buttonStyle;
  final Color? colorTitle;
  const CreateAccountButton({
    super.key,
    this.onTap,
    this.buttonStyle,
    this.colorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: buttonStyle,
      child: Text(
        'Create an account',
        textScaler: const TextScaler.linear(1),
        style: TextStyle(
          color: colorTitle,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class OptionLoginButton extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final void Function()? onTap;
  const OptionLoginButton({
    this.title,
    super.key,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: optionPrimaryButtonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          icon ?? const SizedBox(),
          SizedBox(width: 45.w),
          Expanded(
            flex: 4,
            child: Text(
              '$title',
              textAlign: TextAlign.left,
              softWrap: false,
              textScaler: const TextScaler.linear(1),
              style: TextStyle(
                color: blackColor,
                fontSize: 15.sp,
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

class LoginButton extends StatelessWidget {
  final void Function()? onTap;
  final ButtonStyle? buttonStyle;
  const LoginButton({
    super.key,
    this.onTap,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: buttonStyle,
      child: Text(
        'Sign in',
        textScaler: const TextScaler.linear(1),
        style: TextStyle(
          color: whiteColor,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
