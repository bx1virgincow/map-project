import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mapproject/models/map.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<AddMap>(_onAddMap);
    on<UpdateMap>(_onUpdateMap);
    on<DeleteMap>(_onDeleteMap);
  }

  //function to add map to the map
  void _onAddMap(AddMap event, Emitter<MapState> emit) {
    final state = this.state;
    emit(
      MapState(
        allMapData: List.from(state.allMapData)..add(event.data),
      ),
    );
  }

  //function to update map on the map
  void _onUpdateMap(UpdateMap event, Emitter<MapState> emit) {}

  //function to delete map on the map
  void _onDeleteMap(DeleteMap event, Emitter<MapState> emit) {}
}
