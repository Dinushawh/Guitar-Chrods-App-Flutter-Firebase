// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addnewsong extends StatefulWidget {
  const Addnewsong({super.key});

  @override
  State<Addnewsong> createState() => _AddnewsongState();
}

class _AddnewsongState extends State<Addnewsong> {
  List<bool> checked = [true, true, false, false, true];

  final FirebaseStorage storage = FirebaseStorage.instance;
  late String imageUrl = 'dwa';

  final formKey = GlobalKey<FormState>();
  final songName = TextEditingController();
  final artistName = TextEditingController();
  final category = TextEditingController();
  final chords = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new song'),
        leading: IconButton(
          onPressed: () {
            imageUrl.isEmpty
                ? showDialogBox2(
                    title: 'Warning',
                    content:
                        'You have made some change do you want to continue without saving?')
                : print('image is not empty');
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
                      'Song image',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 1.5,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(75, 224, 224, 224),
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
                        fillColor: const Color.fromARGB(75, 224, 224, 224),
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
                      'Artist name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: artistName,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(75, 224, 224, 224),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter artist name',
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
                    TextFormField(
                      controller: category,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(75, 224, 224, 224),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter song category',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(99, 158, 158, 158)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
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
                      maxLines: 10,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(75, 224, 224, 224),
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
                          backgroundColor:
                              MediaQuery.of(context).platformBrightness ==
                                      Brightness.dark
                                  ? const Color.fromARGB(255, 238, 20, 83)
                                  : const Color.fromARGB(255, 238, 20, 83),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          chords.text.isEmpty ||
                                  songName.text.isEmpty ||
                                  artistName.text.isEmpty ||
                                  category.text.isEmpty ||
                                  imageUrl.isEmpty
                              ? showDialogBox2(
                                  title: 'Error',
                                  content: 'Please fill all the fields',
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("song added"),
                                  ),
                                );

                          // addNewSong(
                          //     artistName: '',
                          //     category: '',
                          //     chrods: '',
                          //     songImage: '',
                          //     songName: '');
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
