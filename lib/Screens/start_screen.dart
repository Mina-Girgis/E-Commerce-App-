import 'package:e_commerce/Screens/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://thumbs.dreamstime.com/b/background-seamless-white-goods-category-online-store-gray-linear-icons-categories-65280732.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 20,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "ZOBA.",
                  style: TextStyle(fontSize: 50, color: Colors.black),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: const Text(
                  "Create an account",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.deepOrange,
                minWidth: 300,
                height: 55,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                ),
                color: Colors.white,
                minWidth: 300,
                height: 55,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 20,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
