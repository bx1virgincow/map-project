import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapproject/bloc/bloc/map_bloc.dart';
import '../../models/map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controllers
  TextEditingController areaNameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  //function to add markers
  void _addMarkers() {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Add Information',
                              style: TextStyle(fontSize: 24.0),
                            ),
                            InkWell(
                                onTap: (() => Navigator.pop(context)),
                                child: const Icon(
                                  Icons.close,
                                  size: 24,
                                )),
                          ],
                        ),
                        const Divider(
                          thickness: 5.0,
                          height: 5.0,
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: areaNameController,
                          autofocus: true,
                          decoration: const InputDecoration(
                              hintText: 'Area Name',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          controller: latController,
                          autofocus: true,
                          decoration: const InputDecoration(
                              hintText: 'Latitude',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          controller: lngController,
                          autofocus: true,
                          decoration: const InputDecoration(
                              hintText: 'Longitude',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Cancel'),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ElevatedButton(
                                onPressed: () {
                                  //5.59538,-0.21586
                                  var data = Data(
                                    areaName: areaNameController.text,
                                    latitude: latController.text,
                                    longitude: lngController.text,
                                  );
                                  _addData();

                                  context
                                      .read<MapBloc>()
                                      .add(AddMap(data: data));
                                },
                                child: const Text('Add'),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ));
  }

  final LatLng _center = const LatLng(5.55602, -0.1969);

  //marker instantiating
  Map<String, Marker> markers = <String, Marker>{};

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //5.59538,-0.21586
  }

  void _addData() {
    final marker = Marker(
      markerId: MarkerId(areaNameController.text),
      position: LatLng(
        double.parse(latController.text),
        double.parse(lngController.text),
      ),
      infoWindow: InfoWindow(
        title: areaNameController.text,
        snippet: areaNameController.text,
      ),
    );
    markers[areaNameController.text] = marker;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  markers: markers.values.toSet(),
                ),
                Positioned(
                  left: 5,
                  right: 5,
                  top: 10,
                  child: SizedBox(
                    height: 50,
                    width: 500,
                    child: TextField(
                      //controller: word,
                      decoration: InputDecoration(
                          hintText: 'Search location',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 2.0,
                              ))),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 100,
                  child: FloatingActionButton(
                    onPressed: () => _addMarkers(),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
