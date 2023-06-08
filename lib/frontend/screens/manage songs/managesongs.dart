import 'package:flutter/material.dart';

class ManageSongs extends StatefulWidget {
  const ManageSongs({super.key});

  @override
  State<ManageSongs> createState() => _ManageSongsState();
}

class _ManageSongsState extends State<ManageSongs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
