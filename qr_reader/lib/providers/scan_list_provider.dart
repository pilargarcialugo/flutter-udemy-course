import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/providers.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> createScan(String value) async {
    final scan = ScanModel(value: value);
    final id = await DBProvider.db.createScan(scan);
    scan.id = id;

    if (selectedType == scan.type) {
      scans.add(scan);
      notifyListeners();
    }

    return scan;
  }

  loadScans() async {
    final scans = await DBProvider.db.findAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.findScansByType(type);
    this.scans = [...scans];
    selectedType = type;
    notifyListeners();
  }

  deleteScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScan(int scanId) async {
    await DBProvider.db.deleteScan(scanId);
    scans = loadScansByType(selectedType);
  }
}
