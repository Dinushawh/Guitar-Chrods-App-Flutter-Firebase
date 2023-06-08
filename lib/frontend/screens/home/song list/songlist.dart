// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/songs/getsongs.dart';
import 'package:guitarchords/frontend/components/chrods/chrodsview.dart';

class SongList extends StatefulWidget {
  const SongList(
      {super.key,
      required this.type,
      required this.category,
      required this.searchValue});

  final String type;
  final String category;
  final String searchValue;

  @override
  State<SongList> createState() => _SongListState();
}

bool isListEmpty = false;

Future isListEmptyCheck(
    {required String type,
    required String category,
    required String searchValue}) async {
  if (type == 'Top Songs') {
    await FirebaseFirestore.instance
        .collection('songs')
        .where(category, arrayContainsAny: [searchValue])
        .get()
        .then((value) {
          if (value.docs.isEmpty) {
            isListEmpty = true;
            print('isListEmpty: $isListEmpty');
          } else {
            isListEmpty = false;
            print('isListEmpty: $isListEmpty');
          }
        });
  } else if (type == 'Top Artist') {
    await FirebaseFirestore.instance.collection('artists').get().then((value) {
      if (value.docs.isEmpty) {
        isListEmpty = true;
        print('isListEmpty: $isListEmpty');
      } else {
        isListEmpty = false;
        print('isListEmpty: $isListEmpty');
      }
    });
  } else if (type == 'Featured Songs') {
    await FirebaseFirestore.instance
        .collection('songs')
        .where(category, arrayContainsAny: [searchValue])
        .get()
        .then((value) {
          if (value.docs.isEmpty) {
            isListEmpty = true;
            print('isListEmpty: $isListEmpty');
          } else {
            isListEmpty = false;
            print('isListEmpty: $isListEmpty');
          }
        });
  } else if (type == 'Artist') {
    await FirebaseFirestore.instance
        .collection('songs')
        .where('artist', isEqualTo: searchValue)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        isListEmpty = true;
        print('isListEmpty: $isListEmpty');
      } else {
        isListEmpty = false;
        print('isListEmpty: $isListEmpty');
      }
    });
  }
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: isListEmptyCheck(
            type: widget.type,
            category: widget.category,
            searchValue: widget.searchValue),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (isListEmpty) {
              return const Center(
                child: Text('No songs found'),
              );
            } else {
              print(widget.type);
              return CustomScrollView(
                  physics: isListEmpty == true
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    customSilverAppBar(context),
                    isListEmpty == true
                        ? const SliverFillRemaining(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Text('No songs found'),
                            ),
                          )
                        : widget.type == 'Top Artists'
                            ? customeSliverListByArtist(snapshot)
                            : customeSilverList(snapshot),
                  ]);
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> customSilverAppBar(
      BuildContext context) {
    return StreamBuilder(
        stream: widget.type == 'Artist'
            ? getBackgroundDetailsofArtist(searchValue: widget.searchValue)
            : getBackgroundDetails(searchValue: widget.searchValue),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SliverAppBar(
              floating: false,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      snapshot.data?.docs[0]['name'],
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
                      imageUrl: snapshot.data?.docs[0]['image'],
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
                              snapshot.data?.docs[0]['name'],
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SliverAppBar(
              expandedHeight: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Text(''),
              ),
            );
          }
        });
  }

  StreamBuilder<QuerySnapshot<Object?>> customeSilverList(
    AsyncSnapshot<dynamic> snapshot,
  ) {
    return StreamBuilder(
        stream:
            getSongList(listType: widget.type, searchValue: widget.searchValue),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data?.docs[index]['image'],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Center(
                            child: Text(
                          'No image found',
                          style: TextStyle(),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    title: Text(snapshot.data?.docs[index]['song name']),
                    subtitle: Text(
                      snapshot.data?.docs[index]['artist'],
                    ),
                    trailing: const Icon(
                      Icons.play_circle_outline,
                      color: Color(0xFFEE1453),
                    ),
                    onTap: () {
                      // addRecentEntry(
                      //   newEntry: [
                      //     {
                      //       'song': snapshot.data?.docs[index]['song name'],
                      //       'image': snapshot.data?.docs[index]['image'],
                      //       'artist': snapshot.data?.docs[index]['artist'],
                      //       'favorite': false,
                      //     }
                      //   ],
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChrodsView(
                            songName: snapshot.data?.docs[index]['song name'],
                            songImage: snapshot.data?.docs[index]['image'],
                            lyrics: snapshot.data?.docs[index]['chord'],
                            artist: snapshot.data?.docs[index]['artist'],
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: snapshot.data?.docs.length,
              ),
            );
          } else {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          }
        });
  }

  StreamBuilder<QuerySnapshot<Object?>> customeSliverListByArtist(
    AsyncSnapshot<dynamic> snapshot,
  ) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('artists').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data?.docs[index]['image'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                              child: Text(
                            'No image found',
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                      title: Text(snapshot.data?.docs[index]['name']),
                      trailing: const Icon(
                        Icons.play_circle_outline,
                        color: Color(0xFFEE1453),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongList(
                              type: 'Artist',
                              category: 'artist',
                              searchValue: snapshot.data?.docs[index]['name'],
                            ),
                          ),
                        );
                        // addRecentEntry(
                        //   newEntry: [
                        //     {
                        //       'song': snapshot.data?.docs[index]['song name'],
                        //       'image': snapshot.data?.docs[index]['image'],
                        //       'artist': snapshot.data?.docs[index]['artist'],
                        //       'favorite': false,
                        //     }
                        //   ],
                        // );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Chords(
                        //       title: snapshot.data?.docs[index]['song name'],
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  );
                },
                childCount: snapshot.data?.docs.length,
              ),
            );
          } else {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          }
        });
  }
}

Stream<QuerySnapshot> getBackgroundDetails({required String searchValue}) {
  return FirebaseFirestore.instance
      .collection('categories')
      .where('name', isEqualTo: searchValue)
      .snapshots();
}

Stream<QuerySnapshot> getBackgroundDetailsofArtist(
    {required String searchValue}) {
  return FirebaseFirestore.instance
      .collection('artists')
      .where('name', isEqualTo: searchValue)
      .snapshots();
}
