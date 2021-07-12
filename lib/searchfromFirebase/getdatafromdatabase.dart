import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:get/get.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('data')
        .where('caption', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
