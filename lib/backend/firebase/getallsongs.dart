import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getallsongs() {
  return FirebaseFirestore.instance.collection('songs').snapshots();
}
