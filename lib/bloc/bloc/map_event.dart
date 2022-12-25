part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

//add map event class
class AddMap extends MapEvent {
  final Data data;
  const AddMap({required this.data});

  @override
  List<Object> get props => [data];
}

//update map event
class UpdateMap extends MapEvent {
  final Data data;
  const UpdateMap({required this.data});

  @override
  List<Object> get props => [data];
}

//delete map
class DeleteMap extends MapEvent {
  final Data data;
  const DeleteMap({required this.data});

  @override
  List<Object> get props => [data];
}
