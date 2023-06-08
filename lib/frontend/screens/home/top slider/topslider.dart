import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/firebase/addrecentdata.dart';
import 'package:guitarchords/backend/firebase/getsongs.dart';
import 'package:guitarchords/frontend/components/chrods/chrodsview.dart';

class Topslider extends StatefulWidget {
  const Topslider({super.key, required this.email, required this.accountType});

  final String accountType;
  final String email;
  @override
  State<Topslider> createState() => _TopsliderState();
}

class _TopsliderState extends State<Topslider> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getsongs(category: 'Top Songs', type: 'category'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      addRecentEntry(
                        accountType: widget.accountType,
                        email: widget.email,
                        songname: snapshot.data?.docs[index]['song name'],
                        imagelink: snapshot.data?.docs[index]['image'],
                        artist: snapshot.data?.docs[index]['artist'],
                        favorite: false,
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
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data?.docs[index]['image'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 250,
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
                          Positioned(
                            bottom: 30,
                            left: 10,
                            child: Text(
                              snapshot.data?.docs[index]['song name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 10,
                            child: Text(
                              snapshot.data?.docs[index]['artist'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
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
