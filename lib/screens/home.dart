import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//list to hold the values of the data set
List<DataModel> model = [];

//declaring the variables
final TextEditingController _name = TextEditingController();
final TextEditingController _xCord = TextEditingController();
final TextEditingController _yCord = TextEditingController();
final TextEditingController _description = TextEditingController();

//text editing controller
final TextEditingController _searchWord = TextEditingController();

class _HomePageState extends State<HomePage> {
  //initializing shared preferences
  late SharedPreferences preferences;

  late Future<DataModel> futureDataModel;

  //sending data to the backend
  Future<DataModel> postData(
      String name, String x_cord, String y_cord, String description) async {
    const endPoint = 'http://10.0.2.2:8000/maps/';
    final http.Response response = await http.post(
      Uri.parse(endPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'name': name,
        'x_cord': x_cord,
        'y_cord': y_cord,
        'description': description
      }),
    );
    if (response.statusCode == 201) {
      debugPrint('data sent to backend');
      return DataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  //implementing the search model

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(5.6184, -0.209);

  //marker instantiating
  Map<String, Marker> markers = <String, Marker>{};
  List<DataModel> mark = [];

  void _onMapCreated(GoogleMapController controller) async {
    mark;

    mapController = controller;
    const api = 'http://10.0.2.2:8000/maps/';
    final response = await http.get(Uri.parse(api));
    final data = json.decode(response.body);

    //setState(() {
    for (var element in data) {
      mark.add(DataModel.fromJson(element));
      final marker = Marker(
        markerId: MarkerId(DataModel.fromJson(element).name),
        position: LatLng(double.parse(DataModel.fromJson(element).x_cord),
            double.parse(DataModel.fromJson(element).y_cord)),
        infoWindow: InfoWindow(
            title: DataModel.fromJson(element).name,
            snippet: DataModel.fromJson(element).description),
      );
      markers[DataModel.fromJson(element).name] = marker;
    }
    setState(() {});
    //});
  }

  //radio value variable
  String? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _center, zoom: 11.0),
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
                  controller: _searchWord,
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
              bottom: 160,
              child: FloatingActionButton(
                onPressed: () => _onMapCreated(mapController),
                child: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              ),
            ),
            Positioned(
              right: 5,
              bottom: 100.0,
              child: FloatingActionButton(
                tooltip: 'Post Data',
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => Container(
                    color: Colors.green[300],
                    height: 400,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Add Coordinate',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              GestureDetector(
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 2.0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _name,
                            decoration: const InputDecoration(
                              hintText: 'Coordinate Name',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _xCord,
                            decoration: const InputDecoration(
                              hintText: 'X Coordinate',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _yCord,
                            decoration: const InputDecoration(
                              hintText: 'Y Coordinate',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _description,
                            decoration: const InputDecoration(
                              hintText: 'Description',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Radio(
                                  value: 'male',
                                  groupValue: state,
                                  fillColor:
                                      MaterialStateProperty.all(Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      state = value.toString();
                                    });
                                    debugPrint('printed');
                                  }),
                              const Text(
                                'Completed',
                                style: TextStyle(color: Colors.white),
                              ),
                              Radio(
                                  value: 'female',
                                  groupValue: state,
                                  fillColor:
                                      MaterialStateProperty.all(Colors.white),
                                  onChanged: (value) {
                                    state = value.toString();
                                    setState(() {});
                                    debugPrint('clicked');
                                  }),
                              const Text(
                                'Incomplete',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _name.text = "";
                                      _xCord.text = "";
                                      _yCord.text = "";
                                      _description.text = "";
                                    },
                                    child: const Text('CLEAR')),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    postData(_name.text, _xCord.text,
                                        _yCord.text, _description.text);

                                    Navigator.pop(context);
                                    print('hello wrold');
                                  },
                                  child: const Text(
                                    'ADD',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget searchBar(BuildContext context) {
  return Container(
    height: 40,
    width: double.infinity,
    child: TextFormField(
      textAlign: TextAlign.center,
      cursorHeight: 1.5,
      decoration: const InputDecoration(
        hintText: 'Search for place..',
        fillColor: Colors.white,
        filled: true,
        //prefixIcon: Icon(Icons.search_sharp),
      ),
    ),
  );
}
