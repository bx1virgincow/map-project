import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapproject/presentation/screens/details_page.dart';

import '../../bloc/bloc/map_bloc.dart';
import '../../models/map.dart';

class MapList extends StatelessWidget {
  const MapList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        List<Data> map = state.allMapData;
        return Scaffold(
          body: SafeArea(
            child: ListView.builder(
                itemCount: map.length,
                itemBuilder: ((context, index) {
                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        e: map[index],
                                      )));
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.red,
                          ),
                          title: Text(map[index].areaName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(map[index].latitude),
                              Text(map[index].longitude),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_outlined),
                          ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        );
      },
    );
  }
}
