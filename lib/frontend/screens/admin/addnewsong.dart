// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/firebase/addnewsongs.dart';
import 'package:image_picker/image_picker.dart';

class Addnewsong extends StatefulWidget {
  const Addnewsong({super.key});

  @override
  State<Addnewsong> createState() => _AddnewsongState();
}

class _AddnewsongState extends State<Addnewsong> {
  List<bool> checked = [true, true, false, false, true];

  final FirebaseStorage storage = FirebaseStorage.instance;
  late String imageUrl = '';

  final formKey = GlobalKey<FormState>();
  final songName = TextEditingController();
  late String artistName = '';
  late String category = '';
  final chords = TextEditingController();

  List<String> splitValues = [];
  List<String> names = [];
  List<String> categories = [];

  Future<List<String>> getNameList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('artists').get();
    names = querySnapshot.docs.map((doc) => doc.get('name') as String).toList();
    return names;
  }

  Future<List<String>> getCategoryList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories =
        querySnapshot.docs.map((doc) => doc.get('name') as String).toList();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNameList().then((value) => getCategoryList()),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add new song'),
              leading: IconButton(
                onPressed: () {
                  imageUrl.isEmpty
                      ? Navigator.pop(context)
                      : showDialogBox2(
                          title: 'Warning',
                          content:
                              'You have made some change do you want to continue without saving?');
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Artist name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(75, 224, 224, 224),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Colors.black,
                              decoration:
                                  const InputDecoration(prefix: Text('    ')),
                              hint: const Text('Please choose artist name'),
                              items: names.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  artistName = value.toString();
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'If you dont get artist name please add it from admin panel',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Song image',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (imageUrl != '')
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CachedNetworkImage(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 1.5,
                                  imageUrl: imageUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                IconButton(
                                  onPressed: () {
                                    getImageGallery();
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 30,
                                  ),
                                ),
                              ],
                            )
                          else
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 1.5,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    getImageGallery();
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Color.fromARGB(255, 133, 133, 133),
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          const Text(
                            'Song name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: songName,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(75, 224, 224, 224),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Enter song name',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(99, 158, 158, 158)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(75, 224, 224, 224),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Colors.black,
                              decoration:
                                  const InputDecoration(prefix: Text('    ')),
                              hint: const Text('Please choose artist name'),
                              items: categories.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  category = value.toString();
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Lyrics with Guitar Chords',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: chords,
                            maxLines: 5,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(75, 224, 224, 224),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Enter  guitar chords and lyrics',
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(99, 158, 158, 158),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.dark
                                    ? const Color.fromARGB(255, 238, 20, 83)
                                    : const Color.fromARGB(255, 238, 20, 83),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                chords.text.isEmpty ||
                                        songName.text.isEmpty ||
                                        artistName.isEmpty ||
                                        category.isEmpty ||
                                        imageUrl.isEmpty
                                    ? showDialogBox2(
                                        title: 'Error',
                                        content: 'Please fill all the fields',
                                      )
                                    : splitValues = category.split(',');
                                addNewSong(
                                  //get category as a list

                                  artistName: artistName,
                                  category: splitValues,
                                  chrods: chords.text,
                                  songImage: imageUrl,
                                  songName: songName.text,
                                )
                                    .then(
                                      (value) => showDialogBox2(
                                        title: 'SUCCESS',
                                        content: 'SONG ADDED SUCCESSFULLY',
                                      ),
                                    )
                                    .then(
                                      (value) => (clearfeilds()),
                                    );
                              },
                              child: const Text('Add song'),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          );
        });
  }

  clearfeilds() {
    chords.clear();
    songName.clear();
    imageUrl = '';
  }

  Future getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No image selected"),
        ),
      );
      return null;
    }
    final path = image.path;
    final filename = image.name;
    uploadFile(path, filename).then((value) => print("Done"));
  }

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      var uploadimg = await storage.ref('songs/$fileName').putFile(file);
      String url = await (uploadimg).ref.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
      print(url);
    } catch (e) {
      print(e);
    }
  }

  Future deleteImage({required String imagerURL}) async {
    try {
      await FirebaseStorage.instance.refFromURL(imagerURL).delete();
    } catch (e) {
      print(e);
    }
  }

  showDialogBox2({required String title, required String content}) =>
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
