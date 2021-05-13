import 'package:cloud_firestore/cloud_firestore.dart';

class AquarioModel {
  String key;
  String name;
  late DocumentReference _measurementsReference;
  List<Map<String, dynamic>> ph = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> no3 = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> no2 = <Map<String, dynamic>>[];
  AquarioModel({required this.key, required this.name});
  fromMap(Map aq) {
    AquarioModel aquarioModel = AquarioModel(key: aq["key"], name: aq["name"]);
    aquarioModel._measurementsReference = aq["MeasuresRef"];
    addMeasurements(aquarioModel);
    return aquarioModel;
  }

  addMeasurements(AquarioModel aquarioModel) async {
    await FirebaseFirestore.instance.doc(aquarioModel._measurementsReference.path).get().then((value) async {
      await Future.wait([
        _addToList(aquarioModel.ph, value.data()?["PH"]),
        _addToList(aquarioModel.no2, value.data()?["NO2"]),
        _addToList(aquarioModel.no3, value.data()?["NO3"])
      ]);
    });
    print("\nPh LIst: \n" + aquarioModel.ph.toList().toString());
    print("\nNO2 LIst: \n" + aquarioModel.no2.toList().toString());
    print("\nNO3 LIst: \n" + aquarioModel.no3.toList().toString());
  }

  Future<bool> _addToList(List<Map<String, dynamic>> list, var values) async {
    for (var val in values) {
      Map<String, dynamic> tmp = {"value": val["value"], "data": (val["date"].toDate())};
      list.add(tmp);
    }
    return true;
  }
}
