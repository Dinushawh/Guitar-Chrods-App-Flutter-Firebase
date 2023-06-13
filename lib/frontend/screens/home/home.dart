import 'package:flutter/material.dart';
import 'package:guitarchords/frontend/components/navigation/sidenavigation.dart';
import 'package:guitarchords/frontend/components/navigation/topnavigation.dart';
import 'package:guitarchords/frontend/screens/home/all%20songs/allsongs.dart';
import 'package:guitarchords/frontend/screens/home/featuredsongs/featuredsongs.dart';
import 'package:guitarchords/frontend/screens/home/top%20slider/artists/artist.dart';
import 'package:guitarchords/frontend/screens/home/top%20slider/topslider.dart';
import 'package:guitarchords/frontend/screens/home/song%20list/songlist.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.accountType,
    required this.email,
  });

  final String accountType;
  final String email;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: Topnavigation(
        onMenuPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Songs",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SongList(
                                type: 'Top Songs',
                                category: 'category',
                                searchValue: 'Top Songs',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEE1453),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Topslider(
                  accountType: widget.accountType,
                  email: widget.email,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 10, right: 10, top: 20, bottom: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Text(
                //         "Viewed Songs",
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //     builder: (context) => const OfflineSongList(
                //           //       title: 'Viewed Songs',
                //           //       songcategory: '',
                //           //     ),
                //           //   ),
                //           // );
                //         },
                //         child: const Text(
                //           "See more",
                //           style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xFFEE1453),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // // RecentlyViewedSongs(
                // //   accountType: widget.accountType,
                // //   email: widget.email,
                // // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Artists",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SongList(
                                type: 'Top Artists',
                                category: 'category',
                                searchValue: 'Top Artists',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEE1453),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 135,
                  child: Artist(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Featured songs",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SongList(
                                type: 'Featured Songs',
                                category: 'category',
                                searchValue: 'Featured Songs',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEE1453),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const FeaturedSongs(
                  songcategory: 'Featured Songs',
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "All songs",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SongList(
                                type: 'All songs',
                                category: 'All songs',
                                searchValue: 'All songs',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEE1453),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const AllSongs()
              ],
            );
          },
        ),
      ),
    );
  }
}
