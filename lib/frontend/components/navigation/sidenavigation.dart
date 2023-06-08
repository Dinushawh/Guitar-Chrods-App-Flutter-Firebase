import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guitarchords/backend/shared/sharedpreferencehelper.dart';
import 'package:guitarchords/frontend/screens/admin/addnewsong.dart';
import 'package:guitarchords/frontend/screens/admin/dashboard.dart';
import 'package:guitarchords/frontend/screens/login/login.dart';

import '../../screens/admin/addartist.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

Future deleteData() async {
  await SharedPrefsHelper.deleteList(
    key: 'userLoggedInToken',
  );
}

navigateToLoggin({required BuildContext context}) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const Login();
      },
    ),
  );
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Colors.black,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 175,
                    width: MediaQuery.of(context).size.width,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: Divider.createBorderSide(context,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                              width: 0.2),
                        ),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: snapshot.data!.docs[0]
                                  ['profile picture'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                snapshot.data!.docs[0]['full name'],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            Text(
                              snapshot.data!.docs[0]['email'],
                              style: TextStyle(
                                fontSize: 14,
                                color: MediaQuery.of(context)
                                            .platformBrightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(132, 68, 68, 68)
                                    : const Color.fromARGB(132, 182, 182, 182),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: [
                              snapshot.data!.docs[0]['account type'] == 'admin'
                                  ? Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.white,
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.white,
                                        ),
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: ExpansionTile(
                                        leading: Icon(
                                          Icons.admin_panel_settings_outlined,
                                          color: MediaQuery.of(context)
                                                      .platformBrightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        title: Text(
                                          'Admin Panel',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.light
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.multitrack_audio_sharp,
                                              color: MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            title: Text(
                                              'Add Chords',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            onTap: () => {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    );
                                                  },
                                                  pageBuilder: (BuildContext
                                                          context,
                                                      Animation<double>
                                                          animation,
                                                      Animation<double>
                                                          secondaryAnimation) {
                                                    return const Addnewsong();
                                                  },
                                                ),
                                              )
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.person_add_alt,
                                              color: MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            title: Text(
                                              'Add Artist',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            onTap: () => {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    );
                                                  },
                                                  pageBuilder: (BuildContext
                                                          context,
                                                      Animation<double>
                                                          animation,
                                                      Animation<double>
                                                          secondaryAnimation) {
                                                    return const AddArtist();
                                                  },
                                                ),
                                              )
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.dashboard_outlined,
                                              color: MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            title: Text(
                                              'Dashboard',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            onTap: () => {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  transitionsBuilder:
                                                      (BuildContext context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation,
                                                          Widget child) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    );
                                                  },
                                                  pageBuilder: (BuildContext
                                                          context,
                                                      Animation<double>
                                                          animation,
                                                      Animation<double>
                                                          secondaryAnimation) {
                                                    return const Dashboard();
                                                  },
                                                ),
                                              )
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.lyrics_outlined,
                                              color: MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            title: Text(
                                              'Manage Songs',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            onTap: () => {},
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.manage_accounts_outlined,
                                              color: MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            title: Text(
                                              'Manage Users',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            onTap: () => {},
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.request_page_outlined,
                                              color: MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            title: Text(
                                              'Requests',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                            onTap: () => {},
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const Divider(
                            color: Color.fromARGB(131, 190, 190, 190),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.person_2_outlined,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            title: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            ),
                            onTap: () => {},
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.favorite_border_rounded,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            title: Text(
                              'My Favorites',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            ),
                            onTap: () => {},
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.audio_file_outlined,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            title: Text(
                              'Request a Songs',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            ),
                            onTap: () => {},
                          ),
                          const Divider(
                            color: Color.fromARGB(131, 190, 190, 190),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.help_outline_rounded,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            title: Text(
                              'Help & Feedback',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                              ),
                            ),
                            onTap: () => {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.power_settings_new,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    onTap: () => {
                      signout(),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      ),
                    },
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
