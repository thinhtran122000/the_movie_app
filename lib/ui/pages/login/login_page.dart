import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/ui.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor.withOpacity(0.9),
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
                ImagesPath.logoAppImage.assetName,
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
                onTap: () {},
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
              child: LoginButton(
                title: 'Sign in with TMDb',
                icon: SvgPicture.asset(
                  ImagesPath.logoAppImage.assetName,
                  fit: BoxFit.scaleDown,
                  width: 22.w,
                  height: 22.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: LoginButton(
                title: 'Sign in with Amazon',
                icon: SvgPicture.asset(
                  ImagesPath.logoAppImage.assetName,
                  fit: BoxFit.scaleDown,
                  width: 22.w,
                  height: 22.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: LoginButton(
                title: 'Sign in with Google',
                icon: SvgPicture.asset(
                  ImagesPath.logoAppImage.assetName,
                  fit: BoxFit.scaleDown,
                  width: 22.w,
                  height: 22.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: LoginButton(
                title: 'Sign in with Apple',
                icon: SvgPicture.asset(
                  ImagesPath.logoAppImage.assetName,
                  fit: BoxFit.scaleDown,
                  width: 22.w,
                  height: 22.h,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 10.h),
            Flexible(
              flex: 2,
              child: LoginButton(
                title: 'Sign in with Facebook',
                icon: SvgPicture.asset(
                  ImagesPath.logoAppImage.assetName,
                  fit: BoxFit.scaleDown,
                  width: 22.w,
                  height: 22.h,
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
                onTap: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      page: const NavigationPage(),
                      begin: const Offset(1, 0),
                    ),
                  );
                },
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
