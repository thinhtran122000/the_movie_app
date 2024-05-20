part of 'discovery_bloc.dart';

class DiscoveryEvent {}

class NavigateTabDiscovery extends DiscoveryEvent {
  final int indexTabDiscovery;
  NavigateTabDiscovery({
    required this.indexTabDiscovery,
  });
}
