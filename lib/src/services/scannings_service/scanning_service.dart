import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/database/scannings_model.dart';

class ScanningService {
  final scanningRef = FirebaseFirestore.instance.collection('Available Scannings').withConverter<ScanningsModel>(
    fromFirestore: (snapshot, _) => ScanningsModel.fromJson(snapshot.data()!),
    toFirestore: (data, _) => data.toJson(),
  );

  Future<List<ScanningsModel>> getScannings() async {
    var querySnapshot = await scanningRef.get();
    var scanningItemList =  querySnapshot.docs.map((doc) => doc.data()).toList();
    return scanningItemList;
  }

}