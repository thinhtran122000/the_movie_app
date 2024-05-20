import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // log(
    // 'Bloc: ${bloc.runtimeType}\nEvent: ${transition.event.runtimeType}\nState: ${transition.currentState.runtimeType} to ${transition.nextState.runtimeType}',
    log('Event: ${transition.event.runtimeType}');
    //   name: 'Bloc',
    // );
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // log('\x1B[31m Error happened in $bloc with error $error and the stacktrace is $stackTrace \x1B[0m');
    super.onError(bloc, error, stackTrace);
  }
}
