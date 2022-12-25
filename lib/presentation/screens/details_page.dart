import 'package:flutter/material.dart';

import '../../models/map.dart';

class DetailsPage extends StatelessWidget {
  final Data e;
  const DetailsPage({Key? key, required this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Details Page')),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 3,
              width: double.infinity,
              color: Colors.red,
              child: const Center(
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
