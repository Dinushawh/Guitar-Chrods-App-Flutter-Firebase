import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getSongList(
    {required String listType, required String searchValue}) {
  if (listType == 'Top Songs') {
    return FirebaseFirestore.instance
        .collection('songs')
        .where('category', arrayContainsAny: [searchValue]).snapshots();
  } else if (listType == 'Top Artist') {
    return FirebaseFirestore.instance.collection('artists').snapshots();
  } else if (listType == 'Artist') {
    return FirebaseFirestore.instance
        .collection('songs')
        .where('artist', isEqualTo: searchValue)
        .snapshots();
  } else {
    return FirebaseFirestore.instance
        .collection('songs')
        .where('category', arrayContainsAny: [searchValue]).snapshots();
  }
}
