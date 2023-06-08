import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: menuItems.length,
        itemBuilder: (BuildContext context, int index) {
          MenuItem menuItem = menuItems[index];
          return menuItem.children == null
              ? ListTile(
                  title: Text(menuItem.title),
                  leading: Icon(menuItem.icon),
                  onTap: () {
                    // Handle tap on main menu item
                  },
                )
              : ExpansionTile(
                  title: Text(menuItem.title),
                  leading: Icon(menuItem.icon),
                  children: menuItem.children!
                      .map((child) => ListTile(
                            title: Text(child.title),
                            leading: Icon(child.icon),
                            onTap: () {
                              // Handle tap on submenu item
                            },
                          ))
                      .toList(),
                );
        },
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final List<MenuItem>? children;

  MenuItem({required this.title, required this.icon, this.children});
}

final List<MenuItem> menuItems = [
  MenuItem(title: 'Home', icon: Icons.home),
  MenuItem(title: 'Categories', icon: Icons.category, children: [
    MenuItem(title: 'Category 1', icon: Icons.arrow_forward_ios),
    MenuItem(title: 'Category 2', icon: Icons.arrow_forward_ios),
    MenuItem(title: 'Category 3', icon: Icons.arrow_forward_ios),
  ]),
  MenuItem(title: 'Settings', icon: Icons.settings),
];
