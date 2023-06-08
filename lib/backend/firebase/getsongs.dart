import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getsongs(
    {required String type, required String category}) {
  return FirebaseFirestore.instance
      .collection('songs')
      .where(type, arrayContainsAny: [category]).snapshots();
}

Stream<QuerySnapshot> getartistsbasedsongs({required String artistName}) {
  return FirebaseFirestore.instance
      .collection('songs')
      .where('artist', isEqualTo: artistName)
      .snapshots();
}

Stream<QuerySnapshot> getsearchsongs({required String name}) {
  return FirebaseFirestore.instance
      .collection('artists')
      .where('name', isEqualTo: name)
      .snapshots();
}
