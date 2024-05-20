import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/pages/authentication/bloc/authentication_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/storage/flutter_storage.dart';
import 'package:tmdb/utils/utils.dart';

class AuthenticationPage extends StatelessWidget {
  final bool? isLaterLogin;
  const AuthenticationPage({
    super.key,
    this.isLaterLogin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc()
        ..add(
          LoadPageAuthentication(
            isLaterLogin: isLaterLogin ?? false,
          ),
        ),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: gainsBoroColor,
            appBar: state.isLaterLogin
                ? CustomAppBar(
                    appBarHeight: 70.h,
                    centerTitle: true,
                    title: state.isLaterLogin ? 'Sign in / create account' : '',
                    titleStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: whiteColor,
                    ),
                    leading: Text(
                      'Cancel',
                      textAlign: TextAlign.left,
                      softWrap: false,
                      textScaler: const TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                        height: 0,
                      ),
                    ),
                    onTapLeading: () => Navigator.of(context).pop(),
                  )
                : null,
            body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return const Center(
                    child: CustomIndicator(
                      radius: 10,
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 2),
                      state.isLaterLogin
                          ? const SizedBox()
                          : Flexible(
                              flex: 3,
                              child: SvgPicture.asset(
                                IconsPath.tmdbIcon.assetName,
                                width: 62.w,
                                height: 62.h,
                              ),
                            ),
                      SizedBox(height: state.isLaterLogin ? 0 : 15.h),
                      Text(
                        state.isLaterLogin ? 'Unlock all that TMDb has to offer' : 'Sign in',
                        textScaler: const TextScaler.linear(1),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: state.isLaterLogin ? 10.h : 30.h),
                      Flexible(
                        flex: 2,
                        child: RegisterButton(
                          colorTitle: whiteColor,
                          buttonStyle: registerPrimaryStyle,
                          onTap: () async {
                            final b = await FlutterStorage().getAllValues();
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
                          onTap: () => Navigator.of(context).pushNamed(
                            AppMainRoutes.login,
                            arguments: {
                              'is_later_login': isLaterLogin,
                            },
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
                      state.isLaterLogin
                          ? const SizedBox()
                          : Flexible(
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/navigation/home',
                                    ModalRoute.withName('/navigation/home'),
                                  );
                                  await FlutterStorage().deleteAllValues();
                                  print('Hello ${await FlutterStorage().getAllValues()}');
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
