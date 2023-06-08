import 'dart:convert';

import 'package:guitarchords/backend/shared/sharedpreferencehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future sessionManager() async {
  bool isUserLoggedIn = false;

  List<Map<String, dynamic>>? userLoggedinData =
      await SharedPrefsHelper.getMapList('userLoggedInToken');
  // ignore: avoid_print
  print(userLoggedinData);

  userLoggedinData == null ? isUserLoggedIn = false : isUserLoggedIn = true;

  return {
    'isUserLoggedIn': isUserLoggedIn,
    'userLoggedInData': userLoggedinData
  };
}

Future addSessionEntry({required List<Map<String, dynamic>> newEntry}) async {
  List<Map<String, dynamic>>? userLoggedData =
      await SharedPrefsHelper.getMapList('userLoggedInToken');

  if (userLoggedData != null) {
    await SharedPrefsHelper.addItemToMapList('userLoggedInToken', newEntry[0]);
  }
}

Future<List<Map<String, dynamic>>?> getMapList(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getString(key);
  if (jsonList != null) {
    final list = json.decode(jsonList) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }
  return null;
}

Future<void> addNewUserEntry(String key, Map<String, dynamic> item) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getString(key);
  List<Map<String, dynamic>> list = [];
  if (jsonList != null) {
    final decodedList = json.decode(jsonList) as List<dynamic>;
    list = decodedList.cast<Map<String, dynamic>>();
  }

  list.add(item);
  await saveMapList(key, list);
}

Future<void> saveMapList(String key, List<Map<String, dynamic>> list) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = json.encode(list);
  await prefs.setString(key, jsonList);
}
