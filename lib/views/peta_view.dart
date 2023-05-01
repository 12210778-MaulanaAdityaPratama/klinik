import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pendataanwarga/providers/peta_provider.dart';
import 'package:provider/provider.dart';

class Petaview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = context.read<PetaProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peta'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: prov.latLng,
              onMapReady: () {
                prov.mapReady = true;
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://mt3.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: prov.latLng,
                    builder: (context) {
                      return Icon(
                        FontAwesomeIcons.mapPin,
                        color: Color.fromARGB(255, 13, 193, 206),
                        size: 40,
                      );
                    },
                  )
                ],
              )
            ],
            mapController: prov.mapController,
          )
        ],
      ),
    );
  }
}
