import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapproject/models/map.dart';
import 'package:mapproject/presentation/pages/bottom_nav.dart';

import 'bloc/bloc/map_bloc.dart';

void main() {
  // final GoogleMapsFlutterPlatform mapsImplementation =
  //     GoogleMapsFlutterPlatform.instance;
  // if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //   mapsImplementation.useAndroidViewSurface = true;
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc()
        ..add(
          AddMap(
            data: Data(
              areaName: 'Alajo',
              latitude: '5.59538',
              longitude: '-0.21586',
            ),
          ),
        ),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: BottomNav(),
      ),
    );
  }
}
