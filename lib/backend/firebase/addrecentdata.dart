import 'package:cloud_firestore/cloud_firestore.dart';

Future addRecentEntry({
  required String accountType,
  required String email,
  required String songname,
  required String artist,
  required String imagelink,
  required bool favorite,
}) async {
  isResentEntryExsist(email: email, songname: songname).then((value) => {
        value == false
            ? FirebaseFirestore.instance.collection('recentlyViewed').add({
                'email': email,
                'songname': songname,
                'date': DateTime.now(),
                'artist': artist,
                'image': imagelink,
                'favorite': favorite,
              })
            : null
      });
}

Future<bool> isResentEntryExsist({
  required String email,
  required String songname,
}) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('recentlyViewed')
      .where('email', isEqualTo: email)
      .where('songname', isEqualTo: songname)
      .get();

  if (querySnapshot.docs.isEmpty) {
    return false;
  } else {
    return true;
  }
}
