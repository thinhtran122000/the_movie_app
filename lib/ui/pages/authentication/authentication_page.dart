import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/ui.dart';
import 'package:movie_app/utils/storage/secure_storage.dart';

class AuthenticationPage extends StatelessWidget {
  final bool isLaterLogin;
  const AuthenticationPage({
    super.key,
    this.isLaterLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: gainsBoroColor,
      appBar: isLaterLogin ? const CustomAppBar() : null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),
            Flexible(
              flex: 3,
              child: SvgPicture.asset(
                IconsPath.tmdbIcon.assetName,
                width: 62.w,
                height: 62.h,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'Sign in',
              textScaler: const TextScaler.linear(1),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blackColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 30.h),
            Flexible(
              flex: 2,
              child: CreateAccountButton(
                colorTitle: whiteColor,
                buttonStyle: createAccountPrimaryButtonStyle,
                onTap: () async {
                  final b = await SecureStorage().getAllValueRequestToken();
                  log('$b');
                },
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              child: Text(
                'or',
                textScaler: const TextScaler.linear(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: OptionLoginButton(
                title: 'Sign in with TMDb',
                icon: SvgPicture.asset(
                  IconsPath.tmdbIcon.assetName,
                  fit: BoxFit.scaleDown,
                  width: 20.w,
                  height: 20.h,
                ),
                onTap: () => Navigator.of(context).push(
                  CustomPageRoute(
                    page: const LoginPage(),
                    begin: const Offset(1, 0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: OptionLoginButton(
                title: 'Sign in with Amazon',
                icon: SvgPicture.asset(
                  IconsPath.amazonIcon.assetName,
                  fit: BoxFit.scaleDown,
                  width: 20.w,
                  height: 20.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: OptionLoginButton(
                title: 'Sign in with Google',
                icon: SvgPicture.asset(
                  IconsPath.googleIcon.assetName,
                  fit: BoxFit.scaleDown,
                  width: 20.w,
                  height: 20.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: OptionLoginButton(
                title: 'Sign in with Apple',
                icon: SvgPicture.asset(
                  IconsPath.appleIcon.assetName,
                  fit: BoxFit.scaleDown,
                  width: 20.w,
                  height: 20.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: OptionLoginButton(
                title: 'Sign in with Facebook',
                icon: SvgPicture.asset(
                  IconsPath.facebookIcon.assetName,
                  fit: BoxFit.scaleDown,
                  width: 20.w,
                  height: 20.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 2,
              child: PrimaryRichText(
                onTapPrimaryHyperlink: () {
                  print('Hello');
                },
                onTapSecondaryHyperlink: () {
                  print('Hello 2');
                },
              ),
            ),
            SizedBox(height: 50.h),
            Flexible(
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  CustomPageRoute(
                    page: const NavigationPage(),
                    begin: const Offset(1, 0),
                  ),
                ),
                child: Text(
                  'Not now',
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
