// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

Future addArtist(
    {required String artistName, required String artistImage}) async {
  await FirebaseFirestore.instance.collection('artists').add({
    'name': artistName,
    'image': artistImage,
  });
}
