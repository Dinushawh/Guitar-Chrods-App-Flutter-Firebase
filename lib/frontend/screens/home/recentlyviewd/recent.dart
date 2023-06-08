// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/firebase/getrecentdata.dart';

class RecentlyViewedSongs extends StatefulWidget {
  const RecentlyViewedSongs(
      {super.key, required this.email, required this.accountType});

  final String accountType;
  final String email;

  @override
  State<RecentlyViewedSongs> createState() => _RecentlyViewedSongsState();
}

class _RecentlyViewedSongsState extends State<RecentlyViewedSongs> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 275, minHeight: 20),
      child: widget.accountType == 'local'
          ? const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Please login to see your recently viewed songs'),
            )
          : StreamBuilder(
              stream: getRecentData(userEmail: widget.email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int count) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.docs[count]['image'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                          title: Text(
                            snapshot.data!.docs[count]['songname'],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[count]['artist'],
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              // setState(() {
                              //   toggleFavorite(count);
                              // });
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Color(0xFFEE1453),
                              // favorite == true
                              //     ? Icons.favorite
                              //     : Icons.favorite_border,
                              // color: const Color(0xFFEE1453),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return const Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()));
              },
            ),
    );
  }
}
