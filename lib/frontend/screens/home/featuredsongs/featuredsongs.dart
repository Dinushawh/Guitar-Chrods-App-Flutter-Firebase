import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/firebase/getsongs.dart';
import 'package:guitarchords/frontend/components/chrods/chrodsview.dart';

class FeaturedSongs extends StatefulWidget {
  const FeaturedSongs({super.key, required this.songcategory});

  final String songcategory;
  @override
  State<FeaturedSongs> createState() => _FeaturedSongsState();
}

class _FeaturedSongsState extends State<FeaturedSongs> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getsongs(category: widget.songcategory, type: 'category'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                              const Duration(milliseconds: 1000),
                          pageBuilder: (_, __, ___) => ChrodsView(
                            songName: snapshot.data?.docs[index]['song name'],
                            songImage: snapshot.data?.docs[index]['image'],
                            lyrics: snapshot.data?.docs[index]['chord'],
                            artist: snapshot.data?.docs[index]['artist'],
                          ),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data?.docs[index]['image'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 150,
                                height: 150,
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
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                      child: Text(
                                'No image found',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            snapshot.data?.docs[index]['song name'].length > 20
                                ? snapshot.data?.docs[index]['song name']
                                        .substring(0, 20) +
                                    '...'
                                : snapshot.data?.docs[index]['song name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            snapshot.data?.docs[index]['artist'],
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
