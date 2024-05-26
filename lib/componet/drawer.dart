
import 'package:flutter/material.dart';
import 'package:notes/componet/drawer_tile.dart';
import 'package:notes/pages/Setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // header
          const DrawerHeader(child: Icon(Icons.edit,)),

          // notes tile
          DrawerTile(
              title: "Home",
               leading: const Icon(Icons.home),
                onTap: () => Navigator.pop(context),
                ),

          // setting
           DrawerTile(
              title: "Setting",
               leading: const Icon(Icons.settings),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const SettingPage()));
                },
                )
        ],
      ),
    );
  }
}
