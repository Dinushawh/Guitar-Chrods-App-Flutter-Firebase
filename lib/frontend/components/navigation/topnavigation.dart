import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Topnavigation extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const Topnavigation({Key? key, required this.onMenuPressed})
      : super(key: key);

  @override
  State<Topnavigation> createState() => _TopnavigationState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopnavigationState extends State<Topnavigation> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: widget.onMenuPressed,
      ),
      actions: [
        Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CachedNetworkImage(
              height: 35,
              width: 35,
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/kioskplus-e45ce.appspot.com/o/ProfilePictures%2Fimage_picker1233972891054024903.jpg?alt=media&token=83880e5c-dcc6-4ccc-a290-8a8b57ab8aeb',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Color(0xFFEE1453),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ]),
      ],
    );
  }
}
