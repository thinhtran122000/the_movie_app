part of 'discovery_bloc.dart';

class DiscoveryState {
  final int indexTabDiscovery;
  DiscoveryState({
    required this.indexTabDiscovery,
  });
}

class DiscoveryInitial extends DiscoveryState {
  DiscoveryInitial({
    required super.indexTabDiscovery,
  });
}

class DiscoverySucess extends DiscoveryState {
  DiscoverySucess({
    required super.indexTabDiscovery,
  });
}
