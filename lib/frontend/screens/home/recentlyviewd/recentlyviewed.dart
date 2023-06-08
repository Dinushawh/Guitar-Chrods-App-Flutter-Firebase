import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/shared/sharedpreferencehelper.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed({super.key});

  @override
  State<RecentlyViewed> createState() => _RecentlyViewedState();
}

Future getData() async {
  await SharedPrefsHelper.getMapList('temporySavedSongs');
}

Future deleteData() async {
  await SharedPrefsHelper.deleteList(
    key: 'temporySavedSongs',
  );
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // deleteData();

    return StreamBuilder(
      stream: SharedPrefsHelper.getMapListStream('temporySavedSongs'),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Map<String, dynamic>>? viewedSongList = snapshot.data;

          return BuildSampleViewdSongsList(
            recevedList: viewedSongList,
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'You have not viewed any songs yet 😥 please view some songs to see them here',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
      },
    );
  }
}

class BuildSampleViewdSongsList extends StatefulWidget {
  const BuildSampleViewdSongsList({
    Key? key,
    required this.recevedList,
  }) : super(key: key);

  final List<Map<String, dynamic>>? recevedList;

  @override
  State<BuildSampleViewdSongsList> createState() =>
      _BuildSampleViewdSongsListState();
}

class _BuildSampleViewdSongsListState extends State<BuildSampleViewdSongsList> {
  late final List<Map<String, dynamic>> _sampleViewdSongs = [];

  @override
  void initState() {
    super.initState();

    if (widget.recevedList != null) {
      _sampleViewdSongs.addAll(widget.recevedList!);
    }
  }

  @override
  Widget build(BuildContext context) {
    int count = _sampleViewdSongs.length;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 275, minHeight: 20),
      child: count == 0
          ? Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                'You have not viewed any songs yet 😥 please view some songs to see them here',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _sampleViewdSongs.length,
              itemBuilder: (BuildContext context, int count) {
                final song = _sampleViewdSongs[count]['song'];
                final artist = _sampleViewdSongs[count]['artist'];
                final image = _sampleViewdSongs[count]['image'];
                final favorite = _sampleViewdSongs[count]['favorite'];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
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
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => const Center(
                          child: Text(
                        'No image found',
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                  title: Text(
                    song,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    artist,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        toggleFavorite(count);
                      });
                    },
                    icon: Icon(
                      favorite == true ? Icons.favorite : Icons.favorite_border,
                      color: const Color(0xFFEE1453),
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     transitionDuration: const Duration(milliseconds: 1000),
                    //     pageBuilder: (_, __, ___) => Chords(
                    //       title: song,
                    //     ),
                    //     transitionsBuilder: (_, animation, __, child) {
                    //       return FadeTransition(
                    //         opacity: animation,
                    //         child: child,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                );
              },
            ),
    );
  }

  void toggleFavorite(int count) {
    if (_sampleViewdSongs[count]['favorite'] == true) {
      _sampleViewdSongs[count]['favorite'] = false;
    } else {
      _sampleViewdSongs[count]['favorite'] = true;
    }
  }
}
