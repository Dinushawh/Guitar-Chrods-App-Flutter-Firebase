// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static Future<void> saveMapList(
      String key, List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = json.encode(list);
    await prefs.setString(key, jsonList);
  }

  static Future<List<Map<String, dynamic>>?> getMapList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getString(key);
    if (jsonList != null) {
      final list = json.decode(jsonList) as List<dynamic>;
      return list.cast<Map<String, dynamic>>();
    }
    return null;
  }

  // Add an item to a list of maps in shared preferences
  static Future<void> addItemToMapList(
      String key, Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getString(key);
    List<Map<String, dynamic>> list = [];
    if (jsonList != null) {
      final decodedList = json.decode(jsonList) as List<dynamic>;
      list = decodedList.cast<Map<String, dynamic>>();
    }

    list.add(item);
    await saveMapList(key, list);
    print('list: $list');
    print(list.length);
  }

  // Update an item in a list of maps in shared preferences
  static Future<void> updateItemInMapList(
      String key, int index, Map<String, dynamic> newItem) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getString(key);
    if (jsonList != null) {
      final decodedList = json.decode(jsonList) as List<dynamic>;
      List<Map<String, dynamic>> list =
          decodedList.cast<Map<String, dynamic>>();
      if (index >= 0 && index < list.length) {
        list[index] = newItem;
        await saveMapList(key, list);
      }
    }
  }

  static deleteList({required String key}) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(key);
    });
  }

  // Delete an item from a list of maps in shared preferences
  static Future<void> deleteItemFromMapList(String key, int index) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getString(key);
    if (jsonList != null) {
      final decodedList = json.decode(jsonList) as List<dynamic>;
      List<Map<String, dynamic>> list =
          decodedList.cast<Map<String, dynamic>>();
      if (index >= 0 && index < list.length) {
        list.removeAt(index);
        await saveMapList(key, list);
      }
    }
  }

  static Stream<List<Map<String, dynamic>>?> getMapListStream(
      String key) async* {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getString(key);
    if (jsonList != null) {
      final list = json.decode(jsonList) as List<dynamic>;
      yield list.cast<Map<String, dynamic>>();
    } else {
      yield null;
    }
  }
}
