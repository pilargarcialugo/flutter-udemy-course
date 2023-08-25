import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    int? id;
    String? type;
    String value;

    LatLng getLatLng() {
      final latLng = value.substring(4).split(',');
      return LatLng(double.parse(latLng[0]), double.parse(latLng[1]));
    }

    ScanModel({
        this.id,
        this.type,
        required this.value,
    }) {
      if (value.contains('http')) {
        type = 'http';
      } else {
        type = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
    };

    @override
    String toString() {
      return toJson().toString();
    }
}
