import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb/observer/observer.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/ui/bloc/tmdb_bloc.dart';
import 'package:tmdb/utils/utils.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await ScreenUtil.ensureScreenSize();
  await PreferencesStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp(
    firsLaunchApp: (PreferencesStorage.getBool(
      'first_launch_app',
    )),
  ));
}

class MyApp extends StatefulWidget {
  final bool? firsLaunchApp;
  const MyApp({
    super.key,
    this.firsLaunchApp,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    clearKeychainValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TmdbBloc(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp(
          title: 'TMDb',
          theme: ThemeData(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: widget.firsLaunchApp == false
              ? AppMainRoutes.navigation
              : AppMainRoutes.authentication,
          onGenerateRoute: AppRouteGenerator.onGenerateMainRoute,
        ),
      ),
    );
  }

  Future<void> clearKeychainValues() async {
    final firsLaunchApp = PreferencesStorage.getBool('first_launch_app');
    if (firsLaunchApp == null || firsLaunchApp == true) {
      await FlutterStorage().deleteAllValues();
      await PreferencesStorage.setBool('first_launch_app', false);
    }
  }
}
