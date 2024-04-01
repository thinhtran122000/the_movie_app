part of 'discovery_bloc.dart';

class DiscoveryState {
  final int indexPage;
  DiscoveryState({
    required this.indexPage,
  });
}

class DiscoveryInitial extends DiscoveryState {
  DiscoveryInitial({
    required super.indexPage,
  });
}

class DiscoverySucess extends DiscoveryState {
  DiscoverySucess({
    required super.indexPage,
  });
}
