import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/pages/profile/bloc/profile_bloc.dart';
import 'package:tmdb/ui/pages/profile/views/general/bloc/general_bloc.dart';

class GeneralView extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  const GeneralView({
    super.key,
    this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneralBloc()..add(LoadPageGeneral()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            BlocProvider.of<GeneralBloc>(context).add(LoadPageGeneral());
          }
        },
        child: BlocBuilder<GeneralBloc, GeneralState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<GeneralBloc>(context);
            if (state is GeneralLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppMainRoutes.authentication,
                          arguments: {
                            'is_later_login': true,
                            'route': AppMainRoutes.profile,
                          },
                        ).then(
                          (results) {
                            if (results != null) {
                              PopResults popResult = results as PopResults;
                              if (popResult.toPage == AppMainRoutes.profile) {
                                // log('Hello ${popResult.results?.values.toList()}');
                                bloc.add(LoadPageGeneral());
                              }
                            }
                          },
                        );
                      },
                      child: const Text(
                        'Login',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigatorKey?.currentState!.pushNamed(
                          AppSubRoutes.settings,
                        );
                      },
                      child: const Text(
                        'Setting',
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                      AppMainRoutes.favorite,
                    ),
                    child: const Text(
                      'My Favorites',
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                      AppMainRoutes.watchlist,
                    ),
                    child: const Text(
                      'My Watchlist',
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      navigatorKey?.currentState!.pushNamed(
                        AppSubRoutes.settings,
                      );
                    },
                    child: const Text(
                      'Setting',
                    ),
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
