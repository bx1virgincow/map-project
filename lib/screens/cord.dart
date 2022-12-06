import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late SharedPreferences preferences;

  //setting a late future data model
  late Future<DataModel> futureDataModel;

  //delete a data from the
  void _deleteData(int id) async {
    final api = 'http://10.0.2.2:8000/detail/$id/';
    final response = await http.delete(
      Uri.parse(api),
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    if (response.statusCode == 204) {
      debugPrint('deleted!');
      //use snackar to show deleted data

      print(response.body);
    } else {
      throw Exception('Failed to delete');
    }
  }

  //load data on every build
  @override
  void initState() {
    //futureDataModel = _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
        centerTitle: true,
      ),
      body: 
      // ListView.builder(
      //     itemCount: _model.length,
      //     itemBuilder: ((context, index) => ListTile(
      //           leading: const Icon(Icons.location_on),
      //           title: Text(_model.elementAt(index).name),
      //           subtitle: Text('X: ' +
      //               _model.elementAt(index).x_cord +
      //               '\n' +
      //               'Y: ' +
      //               _model.elementAt(index).y_cord +
      //               '\n' +
      //               _model.elementAt(index).description),
      //           isThreeLine: true,
      //           trailing: GestureDetector(
      //               onTap: () async => _deleteData(_model.elementAt(index).id),
      //               child: const Icon(Icons.delete)),
      //         ))),

      //     FutureBuilder<DataModel>(
      //   future: futureDataModel,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemBuilder: (context, index) => ListTile(
      //           leading: const Icon(Icons.location_on),
      //           title: Text(snapshot.data!.name),
      //           subtitle: Text(
      //             snapshot.data!.x_cord +
      //                 '\t' +
      //                 snapshot.data!.y_cord +
      //                 '\n' +
      //                 snapshot.data!.description,
      //           ),
      //           isThreeLine: true,
      //           trailing: const Icon(Icons.edit),
      //         ),
      //       );
      //     } else if (snapshot.hasError) {
      //       return Center(
      //           child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           const Text('Loading...'),
      //           const SizedBox(height: 5.0),
      //           CircularProgressIndicator(
      //             color: Colors.green[500],
      //           ),
      //         ],
      //       ));
      //     }
      //     return const Center(child: CircularProgressIndicator());
      //   },
      // ),
    );
  }
}
