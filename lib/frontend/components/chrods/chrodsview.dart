import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/frontend/components/chrods/src/lyrics_renderer.dart';

class ChrodsView extends StatefulWidget {
  const ChrodsView({
    super.key,
    required this.songName,
    required this.songImage,
    required this.lyrics,
    required this.artist,
  });

  final String songName;
  final String songImage;
  final String lyrics;
  final String artist;

  @override
  State<ChrodsView> createState() => _ChrodsViewState();
}

Stream<QuerySnapshot> getSongs(songName) {
  return FirebaseFirestore.instance
      .collection('songs')
      .where('song name', isEqualTo: songName)
      .snapshots();
}

class _ChrodsViewState extends State<ChrodsView> {
  final chordStyle = const TextStyle(fontSize: 20, color: Colors.green);
  final textStyle = const TextStyle(fontSize: 18, color: Colors.white);
  String lyrics = '';
  int transposeIncrement = 0;
  int scrollSpeed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    widget.songName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: widget.songImage,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(1),
                        ],
                        stops: const [0.3, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 40,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            widget.songName,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            widget.artist,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  transposeIncrement--;
                                });
                              },
                              child: const Text('-'),
                            ),
                            const SizedBox(width: 5),
                            Text('$transposeIncrement'),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  transposeIncrement++;
                                });
                              },
                              child: const Text('+'),
                            ),
                          ],
                        ),
                        const Text('Transpose')
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: scrollSpeed <= 0
                                  ? null
                                  : () {
                                      setState(() {
                                        scrollSpeed--;
                                      });
                                    },
                              child: const Text('-'),
                            ),
                            const SizedBox(width: 5),
                            Text('$scrollSpeed'),
                            const SizedBox(width: 5),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  scrollSpeed++;
                                });
                              },
                              child: const Text('+'),
                            ),
                          ],
                        ),
                        const Text('Auto Scroll')
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    color: Colors.black,
                    child: LyricsRenderer(
                      lyrics: lyrics,
                      textStyle: textStyle,
                      chordStyle: chordStyle,
                      onTapChord: (String chord) {},
                      transposeIncrement: transposeIncrement,
                      scrollSpeed: scrollSpeed,
                      widgetPadding: 24,
                      lineHeight: 4,
                      horizontalAlignment: CrossAxisAlignment.start,
                      leadingWidget: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: Text(
                          'Leading Widget',
                          style: chordStyle,
                        ),
                      ),
                      trailingWidget: Text(
                        'Trailing Widget',
                        style: chordStyle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    lyrics =
        widget.lyrics.replaceAll('\\n', '\n').replaceAll('[[VERSE]]', 'VERSE');
  }
}
