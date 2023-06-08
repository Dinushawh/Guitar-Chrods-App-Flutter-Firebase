import 'package:cloud_firestore/cloud_firestore.dart';

Future addNewSong(
    {required String artistName,
    required String category,
    required String chrods,
    required String songImage,
    required String songName}) async {
  await FirebaseFirestore.instance.collection('songs').add({
    'artist': artistName,
    'category': category,
    'chord': chrods,
    'image': songImage,
    'song name': songName,
  });
}
