part of 'discovery_bloc.dart';

class DiscoveryEvent {}

class NavigateTab extends DiscoveryEvent {
  final int indexPage;
  NavigateTab({
    required this.indexPage,
  });
}
