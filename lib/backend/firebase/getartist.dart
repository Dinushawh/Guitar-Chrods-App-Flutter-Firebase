import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getartists() {
  return FirebaseFirestore.instance.collection('artists').snapshots();
}

Stream<QuerySnapshot> getArtistDetailsByName({required String artistName}) {
  return FirebaseFirestore.instance
      .collection('artists')
      .where('name', isEqualTo: artistName)
      .snapshots();
}

Stream<QuerySnapshot> getDetailsByCategory({required String category}) {
  return FirebaseFirestore.instance
      .collection('categories')
      .where('category', isEqualTo: category)
      .snapshots();
}
