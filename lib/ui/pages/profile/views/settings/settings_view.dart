import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/pages/profile/views/settings/bloc/settings_bloc.dart';
import 'package:tmdb/ui/ui.dart';

class SettingsView extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  const SettingsView({
    super.key,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(LoadPageSettings()),
      child: Scaffold(
        backgroundColor: gainsBoroColor,
        appBar: CustomAppBar(
          appBarHeight: 40.h,
          isNested: true,
          centerTitle: true,
          title: 'Settings',
          titleStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
            color: whiteColor,
          ),
          leading: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: 20.sp,
          ),
          onTapLeading: () => navigatorKey?.currentState?.pop(),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                state.hasUser
                    ? OptionSettingsButton(
                        title: 'Account',
                        buttonStyle: optionSettingPrimaryStyle,
                        onTap: () {
                          navigatorKey?.currentState?.pushNamed(AppSubRoutes.account);
                        },
                      )
                    : const SizedBox(),
                Divider(
                  height: 0.h,
                  thickness: 0.7.h,
                  indent: 10.w,
                  color: gainsBoroColor,
                ),
                OptionSettingsButton(
                  title: 'Display',
                  buttonStyle: optionSettingPrimaryStyle,
                  onTap: () {},
                ),
                Divider(
                  height: 0.h,
                  thickness: 0.7.h,
                  indent: 10.w,
                  color: gainsBoroColor,
                ),
                OptionSettingsButton(
                  title: 'Notifications',
                  buttonStyle: optionSettingPrimaryStyle,
                  onTap: () {},
                ),
                Divider(
                  height: 0.h,
                  thickness: 0.7.h,
                  indent: 10.w,
                  color: gainsBoroColor,
                ),
                OptionSettingsButton(
                  title: 'History',
                  buttonStyle: optionSettingPrimaryStyle,
                  onTap: () {},
                ),
                Divider(
                  height: 0.h,
                  thickness: 0.7.h,
                  indent: 10.w,
                  color: gainsBoroColor,
                ),
                OptionSettingsButton(
                  title: 'About',
                  buttonStyle: optionSettingPrimaryStyle,
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
