// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

Future isListEmptyCheck(
    {required String type,
    required String category,
    required String searchValue}) async {
  bool isListEmpty = false;
  if (type == 'Top Songs') {
    await FirebaseFirestore.instance
        .collection('songs')
        .where(category, arrayContainsAny: [searchValue])
        .get()
        .then((value) {
          value.docs.isEmpty ? isListEmpty = true : isListEmpty = false;
          return isListEmpty;
        });
    print(isListEmpty);
  }
}
