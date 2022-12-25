import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/bloc/map_bloc.dart';
import '../../models/map.dart';

class PostData extends StatelessWidget {
  PostData(
      {Key? key,
      required this.areaNameController,
      required this.latController,
      required this.lngController})
      : super(key: key);

  //controllers
  TextEditingController areaNameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  //marker instantiating
  Map<String, Marker> markers = <String, Marker>{};

  @override
  Widget build(BuildContext context) {
    return Container(
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
                hintText: 'Area Name', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 5.0),
          TextField(
            controller: latController,
            autofocus: true,
            decoration: const InputDecoration(
                hintText: 'Latitude', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 5.0),
          TextField(
            controller: lngController,
            autofocus: true,
            decoration: const InputDecoration(
                hintText: 'Longitude', border: OutlineInputBorder()),
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

                    context.read<MapBloc>().add(AddMap(data: data));

                    print(data);
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
