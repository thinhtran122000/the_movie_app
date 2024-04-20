import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/shared_ui.dart';
import 'package:tmdb/ui/components/components.dart';
import 'package:tmdb/ui/pages/details/details.dart';
import 'package:tmdb/ui/pages/home/views/artist/bloc/artist_bloc.dart';
import 'package:tmdb/utils/utils.dart';

class ArtistView extends StatelessWidget {
  const ArtistView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Most popular celebrities',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.artistIcon.assetName,
              width: 24,
            ),
          ),
          BlocBuilder<ArtistBloc, ArtistState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<ArtistBloc>(context);
              if (state is ArtistInitial) {
                return SizedBox(
                  height: 185.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is ArtistError) {
                return SizedBox(
                  height: 185.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return SizedBox(
                height: 185.h,
                child: ListView.separated(
                  controller: bloc.scrollController,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(17.w, 20.h, 17.w, 5.h),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: itemBuilder,
                  separatorBuilder: separatorBuilder,
                  itemCount: state.listArtist.isNotEmpty ? state.listArtist.length + 1 : 21,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = BlocProvider.of<ArtistBloc>(context).state;
    final list = state.listArtist;
    final item = index < list.length ? list[index] : null;
    return SecondaryItem(
      heroTag: '${AppConstants.artistHeroTag}-$index',
      title: item?.name,
      imageUrl:
          item?.profilePath == null ? '' : '${AppConstants.kImagePathPoster}${item?.profilePath}',
      errorImageUrl: getErrorImageWithGender(item?.gender ?? 0),
      index: index,
      itemCount: list.length,
      onTapItem: () => Navigator.of(context).push(
        AppPageRoute(
          builder: (context) => DetailsPage(heroTag: '${AppConstants.artistHeroTag}-$index'),
          begin: const Offset(1, 0),
        ),
      ),
      onTapViewAll: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.h);

  String getErrorImageWithGender(int gender) {
    switch (gender) {
      case 0:
        {
          return ImagesPath.noImageMan.assetName;
        }
      case 1:
        {
          return ImagesPath.noImageWoman.assetName;
        }
      default:
        {
          return ImagesPath.noImageOtherGender.assetName;
        }
    }
  }
}
