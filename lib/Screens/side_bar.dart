import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Michel Magdy",
              style: TextStyle(fontSize: 20),
            ),
            accountEmail: const Text("Example@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/free-vector/floral-ornamental-abstract-background_52683-30016.jpg?w=2000"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.home,
              size: 20,
            ),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.bell),
            title: const Text(
              "Notification",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.list),
            title: const Text(
              "Catergories",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.gear),
            title: Text(
              "Account Settings",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.a),
            title: Text("first"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.arrowRightFromBracket),
            title: Text("Logout"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
