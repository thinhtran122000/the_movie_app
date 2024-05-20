import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:tmdb/ui/pages/profile/views/account/bloc/account_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class AccountView extends StatelessWidget {
  final int? id;
  final String? username;
  final GlobalKey<NavigatorState>? navigatorKey;
  const AccountView({
    super.key,
    this.id,
    this.username,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()
        ..add(
          FetchData(),
        ),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) async {
          if (state is AccountSuccess) {
            navigatorKey?.currentState?.popUntil(
              ModalRoute.withName(AppSubRoutes.general),
            );
            BlocProvider.of<NavigationBloc>(context).add(
              NavigatePage(indexPage: 0),
            );
            BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
              notificationTypes: NotificationTypes.logout,
            ));
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<AccountBloc>(context);
          return Scaffold(
            backgroundColor: gainsBoroColor,
            appBar: CustomAppBar(
              appBarHeight: 40.h,
              isNested: true,
              centerTitle: true,
              title: 'Account',
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
            body: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  overlayColor: MaterialStateProperty.all<Color>(lightGreyColor),
                  onTap: () {},
                  child: Ink(
                    width: double.infinity,
                    color: whiteColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ID',
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '$username-$id',
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0.h,
                  thickness: 0.7.h,
                  indent: 10.w,
                  color: gainsBoroColor,
                ),
                OptionSettingsButton(
                  title: 'Edit profile',
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
                  title: 'Login and security',
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
                  title: 'Personal details',
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
                  title: 'Delete account',
                  buttonStyle: optionSettingPrimaryStyle,
                  onTap: () {},
                ),
                Divider(
                  height: 0.h,
                  thickness: 0.7.h,
                  indent: 10.w,
                  color: gainsBoroColor,
                ),
                SizedBox(height: 20.h),
                LogOutButton(
                  colorTitle: venetianRedColor,
                  buttonStyle: logoutPrimaryStyle,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (dialogContext) => CustomDialog(
                        canPopDialog: true,
                        content: 'Sign out of TMDb?',
                        titleFirstChoice: 'Cancel',
                        titleSecondChoice: 'OK',
                        isMultipleChoice: true,
                        enabledContent: true,
                        enabledTitle: false,
                        image: Lottie.asset(
                          AnimationsPath.pandaSleepAnimation.assetName,
                          repeat: true,
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        ),
                        contentStyle: TextStyle(
                          color: darkBlueColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                        firstChoiceStyle: TextStyle(
                          color: blackColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        secondChoiceStyle: TextStyle(
                          color: blackColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        onTapFirstChoice: () => Navigator.of(dialogContext).pop(),
                        onTapSecondChoice: () {
                          Navigator.of(dialogContext).pop();
                          bloc.add(Logout());
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
