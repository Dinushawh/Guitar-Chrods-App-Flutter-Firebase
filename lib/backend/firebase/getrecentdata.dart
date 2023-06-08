import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getRecentData({required String userEmail}) {
  return FirebaseFirestore.instance
      .collection('recentlyViewed')
      .where('email', isEqualTo: userEmail)
      .snapshots();
}
