part of 'map_bloc.dart';

class MapState extends Equatable {
  final List<Data> allMapData;
  const MapState({this.allMapData = const <Data>[]});

  @override
  List<Object> get props => [allMapData];
}
