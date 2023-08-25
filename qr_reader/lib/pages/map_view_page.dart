import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qr_reader/models/scan_model.dart';

class MapViewPage extends StatefulWidget {
   
  const MapViewPage({Key? key}) : super(key: key);

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel =  ModalRoute.of(context)!.settings.arguments as ScanModel;

    CameraPosition initialPoint = CameraPosition(
      target: scanModel.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: scanModel.getLatLng()
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              await controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: scanModel.getLatLng(),
                  zoom: 17
                )
              ));
            }, 
            icon: const Icon(Icons.location_history_outlined)
          )
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }
          setState(() {});
        },
        child: const Icon(Icons.layers_outlined),
      ),
    );
  }
}