// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UpdateSong extends StatefulWidget {
  const UpdateSong({super.key});

  @override
  State<UpdateSong> createState() => _UpdateSongState();
}

class _UpdateSongState extends State<UpdateSong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Delete Song'),
      ),
    );
  }
}
