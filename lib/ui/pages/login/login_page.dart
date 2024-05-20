import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/pages/login/bloc/login_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class LoginPage extends StatelessWidget {
  final bool? isLaterLogin;
  const LoginPage({
    super.key,
    this.isLaterLogin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(LoadPageLogin()),
      child: Scaffold(
        backgroundColor: gainsBoroColor,
        appBar: CustomAppBar(
          appBarHeight: 70.h,
          centerTitle: true,
          title: '',
          leading: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: 20.sp,
          ),
          onTapLeading: () => Navigator.of(context).pop(),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            switch (state.runtimeType) {
              case LoginLoading:
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  builder: (context) {
                    return CustomDialog(
                      canPopDialog: false,
                      isLoading: true,
                      backgroundColor: darkBlueColor,
                      image: Lottie.asset(
                        AnimationsPath.pandaWalkAnimation.assetName,
                        repeat: true,
                        width: 80.w,
                        height: 80.h,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                      ),
                    );
                  },
                ).timeout(
                  const Duration(seconds: 2),
                  onTimeout: () => Navigator.of(context).pop(),
                );
              case LoginSuccess:
                {
                  if (isLaterLogin ?? false) {
                    Navigator.of(context)
                      ..pop<bool>(isLaterLogin)
                      ..pop<bool>(isLaterLogin);
                    BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                      notificationTypes: NotificationTypes.login,
                    ));
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppMainRoutes.navigation,
                      (route) => false,
                    );
                  }
                }
                break;
              default:
                return;
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<LoginBloc>(context);
            if (state is LoginInitial) {
              return Center(
                child: CustomIndicator(
                  radius: 10.r,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SvgPicture.asset(
                      ImagesPath.tmdbPrimaryShort.assetName,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: whiteSmokeColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: greyColor,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 40.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10.h),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginError) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: redColor,
                                    width: 2.w,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'There was a problem',
                                      style: TextStyle(
                                        color: venetianRedColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      state.statusMessage,
                                      style: TextStyle(
                                        color: blackColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Sign in',
                          textScaler: const TextScaler.linear(1),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Forgot password?',
                          textScaler: const TextScaler.linear(1),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: bloc.emailController,
                          focusNode: bloc.emailFocusNode,
                          margin: EdgeInsets.zero,
                          isAuthentication: true,
                          hintText: 'TMDb username',
                          shadowColor: lightGreyColor,
                          backgroundColor: whiteColor,
                          border: transparentRadiusBorder,
                          enabledBorder: state.error ? redRadiusBorder : lightGreyRadiusBorder,
                          focusedBorder: skyBlueRadiusInputBorder,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                          suffixIcon: bloc.emailController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    bloc.emailController.clear();
                                    bloc.add(ShowClearButton());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Icon(
                                      Icons.clear,
                                      color: darkBlueColor,
                                      size: 20.sp,
                                    ),
                                  ),
                                )
                              : null,
                          onTap: () {},
                          onChanged: (value) => bloc.add(ShowClearButton()),
                          onTapOutside: (event) => bloc.emailFocusNode.unfocus(),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          focusNode: bloc.passwordFocusNode,
                          controller: bloc.passwordController,
                          margin: EdgeInsets.zero,
                          isAuthentication: true,
                          hintText: 'TMDb password',
                          obscureText: state.showPassword,
                          shadowColor: lightGreyColor,
                          backgroundColor: whiteColor,
                          border: transparentRadiusBorder,
                          enabledBorder: state.error ? redRadiusBorder : lightGreyRadiusBorder,
                          focusedBorder: skyBlueRadiusInputBorder,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  bloc.passwordController.text.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: GestureDetector(
                                            onTap: () {
                                              bloc.passwordController.clear();
                                              bloc.add(ShowClearButton());
                                            },
                                            child: Icon(
                                              Icons.clear,
                                              color: darkBlueColor,
                                              size: 20.sp,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  VerticalDivider(
                                    width: 5,
                                    color: lightGreyColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: GestureDetector(
                                      onTap: () => bloc.add(ShowPassword(
                                        showPassword: state.showPassword,
                                      )),
                                      child: SvgPicture.asset(
                                        state.showPassword
                                            ? IconsPath.eyeCloseIcon.assetName
                                            : IconsPath.eyeOpenIcon.assetName,
                                        fit: BoxFit.fill,
                                        width: 15.w,
                                        height: 15.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {},
                          onTapOutside: (event) => bloc.passwordFocusNode.unfocus(),
                          onChanged: (value) => bloc.add(ShowClearButton()),
                        ),
                        SizedBox(height: 20.h),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return LoginButton(
                              buttonStyle: loginPrimaryStyle,
                              onTap: () => bloc.add(Login(
                                username: bloc.emailController.text,
                                password: bloc.passwordController.text,
                              )),
                            );
                          },
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Flexible(
                              flex: 2,
                              child: Divider(
                                height: 1,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                'New to TMDb?',
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Flexible(
                              flex: 2,
                              child: Divider(
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        RegisterButton(
                          colorTitle: darkBlueColor,
                          buttonStyle: registerSecondaryStyle,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      Flexible(
                        flex: 3,
                        child: Text(
                          'Condition of Use',
                          textScaler: const TextScaler.linear(1),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(
                          'Privacy Notice',
                          textScaler: const TextScaler.linear(1),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
