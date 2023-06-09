// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/firebase/addArtist.dart';
import 'package:image_picker/image_picker.dart';

class AddArtist extends StatefulWidget {
  const AddArtist({super.key});

  @override
  State<AddArtist> createState() => _AddArtistState();
}

class _AddArtistState extends State<AddArtist> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late String imageUrl = '';
  final formKey = GlobalKey<FormState>();
  final artistName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new artist'),
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
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                    'Artist name',
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
                          width: MediaQuery.of(context).size.width * 1.5,
                          imageUrl: imageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        IconButton(
                          onPressed: () {
                            openSpecification();
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
                            openSpecification();
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
                        artistName.text.isEmpty || imageUrl.isEmpty
                            ? showDialogBox2(
                                content: "Some feilds are missing",
                                title: 'Error',
                              )
                            : addArtist(
                                    artistImage: imageUrl,
                                    artistName: artistName.text)
                                .then((value) => clerFeilds())
                                .then((value) => showDialogBox2(
                                      content: "Artist added successfully",
                                      title: 'Success',
                                    ));
                      },
                      child: const Text('Add artist'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openSpecification() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Row(
                      children: [
                        const Text(
                          "Select Offer Image",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        const Spacer(),
                        IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text(
                            'Gallery',
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            getImageGallery();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
    uploadFile(path, filename);
  }

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      var uploadimg = await _storage.ref('artists/$fileName').putFile(file);
      String url = await (uploadimg).ref.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sometiing went wrong..!'),
        ),
      );
    }
  }

  clerFeilds() {
    artistName.clear();
    imageUrl = '';
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
