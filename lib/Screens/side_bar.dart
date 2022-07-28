import 'package:e_commerce/Bloc/bloc_cubit.dart';
import 'package:e_commerce/Models/side_bar_data.dart';
import 'package:e_commerce/Screens/account_settings.dart';
import 'package:e_commerce/Screens/homescreen.dart';
import 'package:e_commerce/Screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'favourite_screen.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocCubit.get(context);
    List<SideData> sideData = [
      SideData(icon: FontAwesomeIcons.home, title: "Home"),
      SideData(icon: FontAwesomeIcons.gear, title: "Account Settings"),
      SideData(icon: FontAwesomeIcons.heart, title: "Favourites"),
      SideData(icon: FontAwesomeIcons.arrowRightFromBracket, title: "Logout"),
    ];
    List<Widget> navigation = [
      HomeScreen(),
      AccountSettings(),
      FavouriteScreen(),
      StartScreen(),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "${cubit.currentUser.name}",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              cubit.currentUser.mail,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // cover image if you want to use https://i.pinimg.com/originals/c7/f8/85/c7f885e6d88fe8c762ed06de7386b4a8.jpg
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://media.istockphoto.com/photos/orange-grunge-concrete-wall-textured-and-background-picture-id468375926?k=20&m=468375926&s=612x612&w=0&h=jpYAQ9GFQO4iKMZVsqrrJfU7HT9-J6VvVLl5fgdhFVE="),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Divider(
                      thickness: 1.3,
                    ),
                  );
                },
                itemCount: sideData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      sideData[index].icon,
                      size: 20,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      sideData[index].title,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onTap: () {
                      if (index == 0) {
                        Navigator.pop(context);
                      }
                      else if (index == 3){
                        // logout
                        BlocCubit.currentUserID = -1;
                        cubit.SetFavProducts();
                        cubit.totalPrice=0.0;
                        cubit.cartData.clear();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => navigation[index]));
                        // Navigator.pop(context);
                      }
                      else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => navigation[index]));
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
