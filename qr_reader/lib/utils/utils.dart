import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launch(BuildContext context, ScanModel scanModel) async {
  final Uri url =  Uri.parse(scanModel.value);

  if (scanModel.type == 'http') {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scanModel);
  }
}
