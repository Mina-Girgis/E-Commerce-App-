import 'package:e_commerce/Shared/Components/Network/Local/comments_database.dart';
import 'package:e_commerce/Shared/Components/Network/Remote/diohelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/bloc_cubit.dart';
import 'Screens/start_screen.dart';
import 'Shared/Components/Network/Local/user_database.dart';
import 'Shared/Components/Network/Local/user_fav_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  UsersDatabase.createDatabase();
  UserFavDatabase.createDatabase();
  CommentsDatabase.createDatabase();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocCubit()
        ..getJewelery()
        ..getAll()
        ..getElectronics()
        ..getMenClothing()
        ..getWomenClothing(),
      child: BlocConsumer<BlocCubit, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'BreeSerif',
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  )),
              scaffoldBackgroundColor: Colors.white,
            ),
            home: const Home(),
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StartScreen();
  }
}
