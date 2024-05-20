import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:tmdb/ui/pages/profile/views/general/views/introduction/bloc/introduction_bloc.dart';
import 'package:tmdb/ui/ui.dart';
import 'package:tmdb/utils/utils.dart';

class IntroductionView extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  const IntroductionView({
    super.key,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntroductionBloc()
        ..add(FetchData(
          language: 'en-US',
          sortBy: 'created_at.desc',
        )),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccess) {
                BlocProvider.of<IntroductionBloc>(context).add(FetchData(
                  language: 'en-US',
                  sortBy: 'created_at.desc',
                ));
              }
            },
          ),
          BlocListener<TmdbBloc, TmdbState>(
            listener: (context, state) {
              if (state is TmdbFavoritesSuccess ||
                  state is TmdbWatchlistSuccess ||
                  state is TmdbRatingSuccess ||
                  state is TmdbLoginSuccess ||
                  state is TmdbLogoutSuccess) {
                BlocProvider.of<IntroductionBloc>(context).add(FetchData(
                  language: 'en-US',
                  sortBy: 'created_at.desc',
                ));
              }
            },
          ),
        ],
        child: BlocBuilder<IntroductionBloc, IntroductionState>(
          builder: (context, state) {
            // final bloc = BlocProvider.of<IntroductionBloc>(context);
            if (state is IntroductionInitial) {
              return const Center(
                  child: CustomIndicator(
                radius: 10,
              ));
            }
            return Container(
              decoration: BoxDecoration(
                color: whiteSmokeColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: gainsBoroColor,
                              width: 1.w,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                          ),
                          child: state.hasAccount
                              ? CachedNetworkImage(
                                  imageUrl:
                                      '${AppConstants.kImagePathUserProfile}${state.profilePath}',
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                  width: 30.w,
                                  height: 30.h,
                                )
                              : Icon(
                                  Icons.account_circle_outlined,
                                  color: blackColor,
                                  size: 25.sp,
                                ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          state.name,
                          textScaler: const TextScaler.linear(1),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => navigatorKey?.currentState!.pushNamed(
                            AppSubRoutes.settings,
                            arguments: {
                              'id': state.id,
                              'username': state.username,
                              'has_account': state.hasAccount
                            },
                          ),
                          child: SvgPicture.asset(
                            IconsPath.settingsIcon.assetName,
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  state.hasAccount
                      ? SizedBox(
                          height: 150.h,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: itembuilder,
                            separatorBuilder: separatorBuilder,
                            itemCount: state.multipleList.length,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Sign in or register to access TMDb features including Favorites, Watchlist, Ratings, Lists and more',
                                textScaler: const TextScaler.linear(1),
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              LoginButton(
                                title: 'Sign in / Sign up',
                                buttonStyle: loginPrimaryStyle,
                                onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                                  AppMainRoutes.authentication,
                                  arguments: {
                                    'is_later_login': true,
                                  },
                                ).then(
                                  (results) {
                                    if ((results as bool?) != null && results == true) {
                                      BlocProvider.of<TmdbBloc>(context).add(NotifyStateChange(
                                        notificationTypes: NotificationTypes.login,
                                      ));
                                    } else {
                                      print('Nothings');
                                      return;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget itembuilder(BuildContext context, int index) {
    final bloc = BlocProvider.of<IntroductionBloc>(context);
    return DoudenaryItem(
      title: bloc.state.listTitle[index],
      multipleList: bloc.state.multipleList[index].take(3).toList(),
      content: bloc.state.multipleList[index].length.toString(),
      onTapItem: () => navigatePage(index, context, bloc.state.id),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 10.w);

  navigatePage(int index, BuildContext context, int accountId) {
    switch (index) {
      case 0:
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppMainRoutes.rated,
        );
        return;
      case 1:
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppMainRoutes.favorite,
        );
      case 2:
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppMainRoutes.watchlist,
        );
      case 3:
        break;
      default:
    }
  }
}
