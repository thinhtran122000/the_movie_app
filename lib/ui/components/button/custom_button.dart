import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/utils/app_utils/app_utils.dart';

class RegisterButton extends StatelessWidget {
  final void Function()? onTap;
  final ButtonStyle? buttonStyle;
  final Color? colorTitle;
  const RegisterButton({
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
      style: optionAuthPrimaryStyle,
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

class OptionSettingsButton extends StatelessWidget {
  final void Function()? onTap;
  final ButtonStyle? buttonStyle;
  final String? title;
  const OptionSettingsButton({
    super.key,
    this.onTap,
    this.buttonStyle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: buttonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '$title',
            style: TextStyle(
              color: blackColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15.sp,
            color: lightGreyColor,
          ),
        ],
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  final void Function()? onTap;
  final ButtonStyle? buttonStyle;
  final Color? colorTitle;
  const LogOutButton({
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
        'Sign out',
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


class SortButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData? icon;
  const SortButton({
    super.key,
    this.onTap,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: sortPrimaryStyle,
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Expanded(
            flex: 10,
            child: Text(
              AppUtils().getSortTitle(title),
              textScaler: const TextScaler.linear(1),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteColor,
                fontSize: 14.sp,
              ),
            ),
          ),
          // const Spacer(flex: 1),
          Flexible(
            flex: 1,
            child: Icon(
              icon,
              color: whiteColor,
              size: 25.sp,
            ),
          ),
        ],
      ),
    );
  }
}
