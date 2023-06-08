import 'package:flutter/material.dart';

class RequestSongs extends StatefulWidget {
  const RequestSongs({super.key});

  @override
  State<RequestSongs> createState() => _RequestSongsState();
}

class _RequestSongsState extends State<RequestSongs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Songs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Email address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              // controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(75, 224, 224, 224),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter your email',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(99, 158, 158, 158)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              // controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(75, 224, 224, 224),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter your email',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(99, 158, 158, 158)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              // controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(75, 224, 224, 224),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter your email',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(99, 158, 158, 158)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? const Color.fromARGB(255, 238, 20, 83)
                      : const Color.fromARGB(255, 238, 20, 83),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
