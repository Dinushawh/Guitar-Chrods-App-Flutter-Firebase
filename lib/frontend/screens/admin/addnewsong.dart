import 'package:flutter/material.dart';

class Addnewsong extends StatefulWidget {
  const Addnewsong({super.key});

  @override
  State<Addnewsong> createState() => _AddnewsongState();
}

class _AddnewsongState extends State<Addnewsong> {
  List<bool> checked = [true, true, false, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new song'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                  'Song name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
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
                  maxLines:
                      10, // Set the maximum number of lines to display in the text area
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
                    onPressed: () {},
                    child: const Text('Add song'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
